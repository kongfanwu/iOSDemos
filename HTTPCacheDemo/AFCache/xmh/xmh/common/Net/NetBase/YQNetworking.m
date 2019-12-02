//
//  YQNetworking.m
//  YQNetworking
//
//  Created by yingqiu huang on 2017/2/10.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//

#import "YQNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "YQNetworking+RequestManager.h"
#import "YQCacheManager.h"
#import "XMHEncryptTools.h"
#import "UserInfoRequest.h"
#define YQ_ERROR_IMFORMATION @"网络出现错误，请检查网络连接"

#define YQ_ERROR [NSError errorWithDomain:@"com.hyq.YQNetworking.ErrorDomain" code:-999 userInfo:@{ NSLocalizedDescriptionKey:YQ_ERROR_IMFORMATION}]

static NSMutableArray   *requestTasksPool;

static NSDictionary     *headers;

static YQNetworkStatus  networkStatus;

static NSTimeInterval   requestTimeout = 20.f;


/** 失败的请求参数 */
static NSMutableDictionary * errorParam;
/** 失败请求URL */
static NSString * errorParamUrl;

@implementation YQNetworking
#pragma mark - manager
+ (AFHTTPSessionManager *)manager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //默认解析模式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //配置请求序列化
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    
    [serializer setRemovesKeysWithNullValues:YES];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    manager.requestSerializer.timeoutInterval = requestTimeout;
    
    for (NSString *key in headers.allKeys) {
        if (headers[key] != nil) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    
    //配置响应序列化
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"application/octet-stream",
                                                                              @"application/zip"]];
    
    [self checkNetworkStatus];
    
    //每次网络请求的时候，检查此时磁盘中的缓存大小，阈值默认是40MB，如果超过阈值，则清理LRU缓存,同时也会清理过期缓存，缓存默认SSL是7天，磁盘缓存的大小和SSL的设置可以通过该方法[YQCacheManager shareManager] setCacheTime: diskCapacity:]设置
    [[YQCacheManager shareManager] clearLRUCache];
    
    return manager;
}

#pragma mark - 检查网络
+ (void)checkNetworkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus = YQNetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusUnknown:
                networkStatus = YQNetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus = YQNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus = YQNetworkStatusReachableViaWiFi;
                break;
            default:
                networkStatus = YQNetworkStatusUnknown;
                break;
        }
        
    }];
}

+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasksPool == nil) requestTasksPool = [NSMutableArray array];
    });
    
    return requestTasksPool;
}

#pragma mark - get
+ (YQURLSessionTask *)getWithUrl:(NSString *)url
                  refreshRequest:(BOOL)refresh
                           cache:(BOOL)cache
                          params:(NSDictionary *)params
                   progressBlock:(YQGetProgress)progressBlock
                    successBlock:(YQResponseSuccessBlock)successBlock
                       failBlock:(YQResponseFailBlock)failBlock {
    //将session拷贝到堆中，block内部才可以获取得到session
    __block YQURLSessionTask *session = nil;
    
    AFHTTPSessionManager *manager = [self manager];
    
    if (networkStatus == YQNetworkStatusNotReachable) {
        if (failBlock) failBlock(YQ_ERROR);
        return session;
    }
    
    id responseObj = [[YQCacheManager shareManager] getCacheResponseObjectWithRequestUrl:url params:params];
    
    if (responseObj && cache) {
        if (successBlock) successBlock(responseObj);
    }
    
    session = [manager GET:url
                parameters:params
                  progress:^(NSProgress * _Nonnull downloadProgress) {
                      if (progressBlock) progressBlock(downloadProgress.completedUnitCount,
                                                       downloadProgress.totalUnitCount);
                      
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      if (successBlock) successBlock(responseObject);
                      
                      if (cache) [[YQCacheManager shareManager] cacheResponseObject:responseObject requestUrl:url params:params];
                      
                      [[self allTasks] removeObject:session];
                      
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (failBlock) failBlock(error);
                      [[self allTasks] removeObject:session];
                      
                  }];
    
    if ([self haveSameRequestInTasksPool:session] && !refresh) {
        //取消新请求
        [session cancel];
        return session;
    }else {
        //无论是否有旧请求，先执行取消旧请求，反正都需要刷新请求
        YQURLSessionTask *oldTask = [self cancleSameRequestInTasksPool:session];
        if (oldTask) [[self allTasks] removeObject:oldTask];
        if (session) [[self allTasks] addObject:session];
        [session resume];
        return session;
    }
}

#pragma mark - post
+ (YQURLSessionTask *)postWithUrl:(NSString *)url
                   refreshRequest:(BOOL)refresh
                            cache:(BOOL)cache
                           params:(NSDictionary *)params
                    progressBlock:(YQPostProgress)progressBlock
                     successBlock:(YQResponseSuccessBlock)successBlock
                        failBlock:(YQResponseFailBlock)failBlock {
    __block YQURLSessionTask *session = nil;
    
    AFHTTPSessionManager *manager = [self manager];
    
    if (networkStatus == YQNetworkStatusNotReachable) {
        if (failBlock) failBlock(YQ_ERROR);
        return session;
    }
    
    id responseObj = [[YQCacheManager shareManager] getCacheResponseObjectWithRequestUrl:url params:params];
    
    if (responseObj && cache) {
        if (successBlock) successBlock(responseObj);
    }
    
    session = [manager POST:url
                 parameters:params
                   progress:^(NSProgress * _Nonnull uploadProgress) {
                       if (progressBlock) progressBlock(uploadProgress.completedUnitCount,
                                                        uploadProgress.totalUnitCount);
                       
                   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                       if (successBlock) successBlock(responseObject);
                       
                       if (cache) [[YQCacheManager shareManager] cacheResponseObject:responseObject requestUrl:url params:params];
                       
                       if ([[self allTasks] containsObject:session]) {
                           [[self allTasks] removeObject:session];
                       }
                       
                       NSDictionary * responseDic = (NSDictionary *)responseObject;
                       NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responseDic options:NSJSONWritingPrettyPrinted error:nil];
                       [self pointLogTask:task param:params respData:jsonData error:nil];
                       
                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                       if (failBlock) failBlock(error);
                       [[self allTasks] removeObject:session];
                       [self pointLogTask:task param:params respData:nil error:nil];
                   }];
    
    
    if ([self haveSameRequestInTasksPool:session] && !refresh) {
        [session cancel];
        return session;
    }else {
        YQURLSessionTask *oldTask = [self cancleSameRequestInTasksPool:session];
        if (oldTask) [[self allTasks] removeObject:oldTask];
        if (session) [[self allTasks] addObject:session];
        [session resume];
        return session;
    }
}
+ (YQURLSessionTask *)postWithUrl:(NSString *)url
                   refreshRequest:(BOOL)refresh
                            cache:(BOOL)cache
                           params:(NSDictionary *)params
                    progressBlock:(YQPostProgress)progressBlock
                      resultBlock:(void(^)(BaseModel * obj,
                                           BOOL isSuccess,
                                           NSError * error))resultBlock
{
 
    NSMutableDictionary * xmhParam = [[NSMutableDictionary alloc] initWithDictionary:params];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    [xmhParam setValue:token forKey:@"token"];
    /**
        1、判断有没有 join_code 没有的话添加
        2、有的话不用替换  方便测试用
     
     */
    if (![xmhParam.allKeys containsObject:@"join_code"]) {
        NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
        [xmhParam setValue:joinCode?joinCode:@"" forKey:@"join_code"];
    }
    NSDate *datenow = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    //    /** 加入时间戳 */
    [xmhParam setValue:timestamp forKey:@"timestamp"];
    [xmhParam setValue:url  forKey:@"url"];
    NSInteger recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSInteger randomNumberN = arc4random_uniform(100000);
    /** 随机串有 毫秒级时间戳+10w内随机数 */
    NSString * nonce = [NSString stringWithFormat:@"%ld%ld",recordTime,randomNumberN];
    [xmhParam setValue:nonce forKey:@"nonce"];
    NSString * sign = [XMHEncryptTools encryptbyParam:xmhParam];
    [xmhParam setValue:sign forKey:@"sign"];
    /** url 只作为签名排序用 不作为参数提交 */
    [xmhParam removeObjectForKey:@"url"];
    
    YQURLSessionTask * task = [self postWithUrl:url refreshRequest:refresh cache:cache params:xmhParam progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        
    } successBlock:^(id response) {
        BaseModel  * baseModel = [BaseModel yy_modelWithDictionary:response];
        if (baseModel.code == 1) {
            resultBlock(baseModel,YES,nil);
        }else{
            [XMHProgressHUD showOnlyText:baseModel.msg];
            resultBlock(baseModel,NO,nil);
        }
        
        
    } failBlock:^(NSError *error) {
        [XMHProgressHUD showOnlyText:@"接口错误"];
        resultBlock(nil,NO,error);
    }];
    
    NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = responses.statusCode;
    /** token 过期 */
    if (statusCode == 401) {
        errorParam = xmhParam;
        errorParamUrl = url;
        [UserInfoRequest requestLoginAccount:model.data.account Password:model.data.password resultBlock:^(LolUserInfoModel *longinModel, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                
                /** 替换为新的token */
                [errorParam setValue:longinModel.data.token forKey:@"token"];
                /** 将签名移除 重新请求做签名 */
                [errorParam removeObjectForKey:@"sign"];
                 
                 [self postWithUrl:errorParamUrl refreshRequest:NO cache:NO params:errorParam progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
                     
                 } resultBlock:^(BaseModel *obj, BOOL isSuccess, NSError *error) {
                     if (isSuccess) {
                         if (obj.code == 1) {
                             resultBlock(obj,YES,nil);
                         }else{
                             [XMHProgressHUD showOnlyText:obj.msg];
                             resultBlock(obj,NO,nil);
                         }
                     }else{
                         resultBlock(nil,NO,error);
                     }
                     
                 }];
            }
        }];
    }else{
        
    }
    return task;
}
#pragma mark - 文件上传
+ (YQURLSessionTask *)uploadFileWithUrl:(NSString *)url
                               fileData:(NSData *)data
                                   type:(NSString *)type
                                   name:(NSString *)name
                               mimeType:(NSString *)mimeType
                          progressBlock:(YQUploadProgressBlock)progressBlock
                           successBlock:(YQResponseSuccessBlock)successBlock
                              failBlock:(YQResponseFailBlock)failBlock {
    __block YQURLSessionTask *session = nil;
    
    AFHTTPSessionManager *manager = [self manager];
    
    if (networkStatus == YQNetworkStatusNotReachable) {
        if (failBlock) failBlock(YQ_ERROR);
        return session;
    }
    
    session = [manager POST:url
                 parameters:nil
  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      NSString *fileName = nil;
      
      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = @"yyyyMMddHHmmss";
      
      NSString *day = [formatter stringFromDate:[NSDate date]];
      
      fileName = [NSString stringWithFormat:@"%@.%@",day,type];
      
      [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
      
  } progress:^(NSProgress * _Nonnull uploadProgress) {
      if (progressBlock) progressBlock (uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      if (successBlock) successBlock(responseObject);
      [[self allTasks] removeObject:session];
      
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      if (failBlock) failBlock(error);
      [[self allTasks] removeObject:session];
      
  }];

    
    [session resume];
    
    if (session) [[self allTasks] addObject:session];
    
    return session;
}

#pragma mark - 多文件上传
+ (NSArray *)uploadMultFileWithUrl:(NSString *)url
                         fileDatas:(NSArray *)datas
                              type:(NSString *)type
                              name:(NSString *)name
                          mimeType:(NSString *)mimeTypes
                     progressBlock:(YQUploadProgressBlock)progressBlock
                      successBlock:(YQMultUploadSuccessBlock)successBlock
                         failBlock:(YQMultUploadFailBlock)failBlock {
    
    if (networkStatus == YQNetworkStatusNotReachable) {
        if (failBlock) failBlock(@[YQ_ERROR]);
        return nil;
    }
    
    __block NSMutableArray *sessions = [NSMutableArray array];
    __block NSMutableArray *responses = [NSMutableArray array];
    __block NSMutableArray *failResponse = [NSMutableArray array];
    
    dispatch_group_t uploadGroup = dispatch_group_create();
    
    NSInteger count = datas.count;
    for (int i = 0; i < count; i++) {
        __block YQURLSessionTask *session = nil;
        
        dispatch_group_enter(uploadGroup);
        
        session = [self uploadFileWithUrl:url
                                 fileData:datas[i]
                                     type:type name:name
                                 mimeType:mimeTypes
                            progressBlock:^(int64_t bytesWritten, int64_t totalBytes) {
                                if (progressBlock) progressBlock(bytesWritten,
                                                                 totalBytes);
                                
                            } successBlock:^(id response) {
                                [responses addObject:response];
                                
                                dispatch_group_leave(uploadGroup);
                                
                                [sessions removeObject:session];
                                
                            } failBlock:^(NSError *error) {
                                NSError *Error = [NSError errorWithDomain:url code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"第%d次上传失败",i]}];
                                
                                [failResponse addObject:Error];
                                
                                dispatch_group_leave(uploadGroup);
                                
                                [sessions removeObject:session];
                            }];
        
        [session resume];
        
        if (session) [sessions addObject:session];
    }
    
    [[self allTasks] addObjectsFromArray:sessions];
    
    dispatch_group_notify(uploadGroup, dispatch_get_main_queue(), ^{
        if (responses.count > 0) {
            if (successBlock) {
                successBlock([responses copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
        
        if (failResponse.count > 0) {
            if (failBlock) {
                failBlock([failResponse copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
        
    });
    
    return [sessions copy];
}

#pragma mark - 下载
+ (YQURLSessionTask *)downloadWithUrl:(NSString *)url
                        progressBlock:(YQDownloadProgress)progressBlock
                         successBlock:(YQDownloadSuccessBlock)successBlock
                            failBlock:(YQDownloadFailBlock)failBlock {
    NSString *type = nil;
    NSArray *subStringArr = nil;
    __block YQURLSessionTask *session = nil;
    
    NSURL *fileUrl = [[YQCacheManager shareManager] getDownloadDataFromCacheWithRequestUrl:url];
    
    if (fileUrl) {
        if (successBlock) successBlock(fileUrl);
        return nil;
    }
    
    if (url) {
        subStringArr = [url componentsSeparatedByString:@"."];
        if (subStringArr.count > 0) {
            type = subStringArr[subStringArr.count - 1];
        }
    }
    
    AFHTTPSessionManager *manager = [self manager];
    //响应内容序列化为二进制
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    session = [manager GET:url
                parameters:nil
                  progress:^(NSProgress * _Nonnull downloadProgress) {
                      if (progressBlock) progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                      
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      if (successBlock) {
                          NSData *dataObj = (NSData *)responseObject;
                          
                          [[YQCacheManager shareManager] storeDownloadData:dataObj requestUrl:url];
                          
                          NSURL *downFileUrl = [[YQCacheManager shareManager] getDownloadDataFromCacheWithRequestUrl:url];
                          
                          successBlock(downFileUrl);
                      }
                      
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (failBlock) {
                          failBlock (error);
                      }
                  }];
    
    [session resume];
    
    if (session) [[self allTasks] addObject:session];
    
    return session;
    
}

#pragma mark - other method
+ (void)setupTimeout:(NSTimeInterval)timeout {
    requestTimeout = timeout;
}

+ (void)cancleAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(YQURLSessionTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YQURLSessionTask class]]) {
                [obj cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(YQURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YQURLSessionTask class]]) {
                if ([obj.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [obj cancel];
                    *stop = YES;
                }
            }
        }];
    }
}

+ (void)configHttpHeader:(NSDictionary *)httpHeader {
    headers = httpHeader;
}

+ (NSArray *)currentRunningTasks {
    return [[self allTasks] copy];
}
+ (void)pointLogTask:(NSURLSessionDataTask *)task param:(NSDictionary *)param respData:(NSData *)respData error:(NSError *)error {
#ifdef DEBUG
    char * _Nullable response = NULL;
    if (error) {
        NSData *respData = ((NSError *) ((NSError *)error).userInfo[NSUnderlyingErrorKey]).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (respData.length > 0) {
            response = (char *)[[[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding] UTF8String];
        }
    } else if (respData.length) {
        response = (char *)[[[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding] UTF8String];
    }
    
    NSString *requestURL;
    if ([task isKindOfClass:[NSURLSessionTask class]]) {
        NSString *paramString = [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding];
        requestURL = [NSString stringWithFormat:@"%@ %@/%@", task.originalRequest.HTTPMethod, [task.originalRequest.URL absoluteString], paramString];
    } else if ([task isKindOfClass:[NSHTTPURLResponse class]]) {
        requestURL = ((NSHTTPURLResponse *)task).URL.absoluteString;
    }
    printf("👉👉👉👉👉👉👉👉👉👉\n");
    NSLog(@"%@ \nrequest parameters:\n %@", requestURL, param);
    printf("response:\n %s \n", response);
    printf("👈👈👈👈👈👈👈👈👈👈\n");
#endif
}
@end

@implementation YQNetworking (cache)
+ (NSUInteger)totalCacheSize {
    return [[YQCacheManager shareManager] totalCacheSize];
}

+ (NSUInteger)totalDownloadDataSize {
    return [[YQCacheManager shareManager] totalDownloadDataSize];
}

+ (void)clearDownloadData {
    [[YQCacheManager shareManager] clearDownloadData];
}

+ (NSString *)getDownDirectoryPath {
    return [[YQCacheManager shareManager] getDownDirectoryPath];
}

+ (NSString *)getCacheDiretoryPath {
    
    return [[YQCacheManager shareManager] getCacheDiretoryPath];
}

+ (void)clearTotalCache {
    [[YQCacheManager shareManager] clearTotalCache];
}

@end
