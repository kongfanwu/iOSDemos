//
//  Networking.m
//  AFNtest
//
//  Created by caoyinliang on 16/5/6.
//  Copyright © 2016年 51credit.com. All rights reserved.
//

#import "Networking.h"
#import <AdSupport/AdSupport.h>
#import "AFNetworking.h"
#import "NSString+DE.h"
#import "UploadImgInfo.h"
//#import "MBProgressHUD+NHAdd.h"
#import "UserManager.h"
#import "LolUserInfoModel.h"
#import "UserInfoRequest.h"
#import "ShareWorkInstance.h"
#import "XMHEncryptTools.h"
static AFHTTPSessionManager *manger;
static int currentRequestCount = 0;
/** 失败的请求参数 */
static NSMutableDictionary * errorParam;
/** 失败请求URL */
static NSString * errorParamUrl;
@implementation Networking
{
  
}
// 对外请求接口
+ (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                  params:(NSMutableDictionary *)params
                           requsetMethod:(EAFRequestMethod)requsetMethod
                                 success:(void (^_Nullable)(id _Nullable result))success
                                    fail:(void (^_Nullable)(id _Nullable errorresult))fail;
{
    NSURLSessionDataTask *_task = nil;
    
    if (requsetMethod == EAFRequestMethod_Get) {
        _task = [self createRequestOperationrNoHeaderGetWithURL:url params:params progress:nil success:success fail:fail];
    } else if (requsetMethod == EAFRequestMethod_Post) {
        _task = [self createRequestOperationNoHeaderPostWihtUrl:url params:params progress:nil success:success fail:fail];
    }
    return _task;
    
//    NSURLSessionDataTask *_task = nil;
//    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
//    [params setValue:joinCode?joinCode:@"" forKey:@"join_code"];
//    [params setValue:@"1" forKey:@"cnmtp"];
//    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
//    NSString    *oldtoken = model.data.token;
//    [params setValue:oldtoken forKey:@"token"];
//
//    if (requsetMethod == EAFRequestMethod_Get) {
//
//        //        _task = [self createRequestOperationrNoHeaderGetWithURL:url params:params progress:nil success:success fail:fail];
//        [YQNetworking getWithUrl:url refreshRequest:NO cache:NO params:params progressBlock:nil successBlock:^(id response) {
//            success(response);
//        } failBlock:^(NSError *error) {
//            fail(error);
//        }];
//    } else if (requsetMethod == EAFRequestMethod_Post) {
//        //        _task = [self createRequestOperationNoHeaderPostWihtUrl:url params:params progress:nil success:success fail:fail];
//        [YQNetworking postWithUrl:url refreshRequest:NO cache:NO params:params progressBlock:nil successBlock:^(id response) {
//            success(response);
//        } failBlock:^(NSError *error) {
//            fail(error);
//        }];
//    }
//    return _task;
}

+ (NSURLSessionDataTask *)UploadWithURL:(NSString *)url
                              params:(NSMutableDictionary *)params
                            progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                success:(void (^_Nullable)(id _Nullable result))success
                                   fail:(void (^_Nullable)(id _Nullable errorresult))fail;
{
    return [self createRequestOperationNoHeaderPostWihtUrl:url params:params progress:uploadProgress success:success fail:fail];
}

#pragma mark - Private Method
// Get请求方法
+ (NSURLSessionDataTask *)createRequestOperationrNoHeaderGetWithURL:(NSString *)url
                                                             params:(NSMutableDictionary *)params
                                                           progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                                            success:(void (^_Nullable)(id _Nullable result))success
                                                               fail:(void (^_Nullable)(id _Nullable errorresult))fail;
{
    // 创建request请求管理对象
    AFHTTPSessionManager *_manager = [self currentManger];    
//    __block double start = [[NSDate new] timeIntervalSince1970];
    
    NSURLSessionDataTask *_task = [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        if (success) {
//            [PreliminaryAnalysis resolveResultDataWithResult:task responseObject:responseObject success:success fail:fail];
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        OutLog(@"====GET failure====  %@", error.description);
//        OutLog(@">>>>>>>>>>>>>>>>>>>>>>>>>post:%@", [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
        
//        NSInteger statusCode = [(NSHTTPURLResponse *)task.response statusCode];
        // 统计
//        [InterfaceStatistics portGETCount:task responseObject:nil url:url statusCode:statusCode startTime:start];
        if (fail) {
//            fail([@{NETWORK_RESPONSE_ERROR:[NSString stringWithFormat:@"%@[%@]", NETWORK_RESPONSE_ERROR_MSG, @(statusCode)]} mutableCopy], 0);
        }
    }];
    return _task;
}

// Post请求方法
+ (NSURLSessionDataTask*)createRequestOperationNoHeaderPostWihtUrl:(NSString *)url
                                                            params:(NSMutableDictionary *)params
                                                          progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                                           success:(void (^_Nullable)(id _Nullable result))success
                                                              fail:(void (^_Nullable)(id _Nullable errorresult))fail;
{
    NSMutableDictionary *paramsM = [NSMutableDictionary dictionaryWithDictionary:params.copy];
    // 创建request请求管理对象
    AFHTTPSessionManager *_manager = [self currentManger];
  __block  NSURLSessionDataTask *_task = nil;
    __block  NSURLSessionDataTask * errorTask = nil;
    __block  NSString * errorUrl = @"";
    __block  NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    
    // 判断请求参数是否是文件数据
    BOOL isFile = NO;
    for (NSString * key in paramsM.allKeys) {
        if([key isEqualToString:KEY_FILE_UPLOADIMG]){
            isFile = YES;
            break;
        }
        id value = paramsM[key];
        if ([value isKindOfClass:[NSData class]]) {
            isFile = YES;
            break;
        } else if([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *_tempArray = (NSMutableArray*)value;
            for (id obj in _tempArray) {
                if ([obj isKindOfClass:[NSData class]]) {
                    isFile = YES;
                    break;
                }
            }
        }
    }
    
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    
    if (token) {
        if ([url isEqualToString:[NSString stringWithFormat:@"%@v5.login/index",SERVER_APP]]) {
        
        }else{
           [paramsM setValue:token forKey:@"token"];
        }
    }
    NSString * joinCode = [ShareWorkInstance shareInstance].join_code;
    [paramsM setValue:joinCode?joinCode:@"" forKey:@"join_code"];
    [paramsM setValue:@"1" forKey:@"cnmtp"];
    NSDate *datenow = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//    /** 加入时间戳 */
    [paramsM setValue:timestamp forKey:@"timestamp"];
    [paramsM setValue:url forKey:@"url"];
    NSInteger recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSInteger randomNumberN = arc4random_uniform(100000);
    /** 随机串有 毫秒级时间戳+10w内随机数 */
    NSString * nonce = [NSString stringWithFormat:@"%ld%ld",recordTime,randomNumberN];
    [paramsM setValue:nonce forKey:@"nonce"];
    NSString * sign = [XMHEncryptTools encryptbyParam:paramsM];
    [paramsM setValue:sign forKey:@"sign"];
    /** url 只作为签名排序用 不作为参数提交 */
    [paramsM removeObjectForKey:@"url"];
    if (!isFile) { // 参数中没有文件，则使用简单的post请求
        LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
        NSString    *oldtoken = model.data.token;
        MzzLog(@"old...............%@",oldtoken);
        if (token) {
            [paramsM setValue:oldtoken forKey:@"token"];
        }
        if (currentRequestCount ++ <1) {
            [XMHProgressHUD showGifImage];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:paramsM];
        
       
        _task = [_manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //弹出成功
            if (currentRequestCount--<2 ) {
                [XMHProgressHUD dismiss];
            }
            NSDictionary * responseDic = (NSDictionary *)responseObject;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responseDic options:NSJSONWritingPrettyPrinted error:nil];
            [self pointLogTask:task param:dic respData:jsonData error:nil];
            
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //弹出失败
            if (currentRequestCount-- <2) {
                
                [XMHProgressHUD dismiss];
            }
            
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            NSInteger statusCode = responses.statusCode;
            /** token 过期 */
            if (statusCode == 401) {
                errorTask = _task;
                errorUrl = url;
                dict = dic;
                errorParam = dict;
                errorParamUrl = errorUrl;
                [UserInfoRequest requestLoginAccount:model.data.account Password:model.data.password resultBlock:^(LolUserInfoModel *longinModel, BOOL isSuccess, NSDictionary *errorDic) {
                    if (isSuccess) {
                        
                        /** 替换为新的token */
                        [errorParam setValue:longinModel.data.token forKey:@"token"];
                        /** 将签名移除 重新请求做签名 */
                        [errorParam removeObjectForKey:@"sign"];
                        
                         [self createRequestOperationNoHeaderPostWihtUrl:errorParamUrl params:errorParam progress:^(NSProgress * _Nonnull uploadProgress) {
                             
                         } success:^(id  _Nullable result) {
                             
                         } fail:^(id  _Nullable errorresult) {
                             
                         }];
                    }
                }];
                /**
                 401 时 不作为错误范围 上层网络请求 报网络请求错误
                 fail()  不回调
                 */
            }else{
                [self pointLogTask:task param:dic respData:nil error:error];
                fail(error);
            }
           
        }];
    } else {
        
       _task = [_manager POST:url parameters:paramsM constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
           // 参数中含有文件，则使用文件传参的post请求
           [self addFileDataWithParams:paramsM formData:formData];
        } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 统计
//            [InterfaceStatistics portPOSTCount:task responseObject:nil url:url statusCode:200 startTime:start];
            if (success) {
                success(responseObject);
//                [PreliminaryAnalysis resolveResultDataWithResult:task responseObject:responseObject success:success fail:fail];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            OutLog(@"====POST failure====  %@", error.description);
//            OutLog(@">>>>>>>>>>>>>>>>>>>>>>>>>post:%@", [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
           
//            NSInteger statusCode = [(NSHTTPURLResponse *)task.response statusCode];
            // 统计
//            [InterfaceStatistics portPOSTCount:task responseObject:nil url:url statusCode:statusCode startTime:start];
            if (fail) {
//                fail([@{NETWORK_RESPONSE_ERROR:[NSString stringWithFormat:@"%@[%@]", NETWORK_RESPONSE_ERROR_MSG, @(statusCode)]} mutableCopy], 0);
                 fail(error);
            }
        }];
        
    }
    return _task;
}

// 加载NSData参数(上传图片等)
+ (void)addFileDataWithParams:(id)params formData:(id<AFMultipartFormData>)formData
{
    //处理604上传-图片上传服务器接口
    for (NSString *key in params) {
        if([key isEqualToString:KEY_FILE_UPLOADIMG]){
            NSArray *array = (NSArray *)(params[key]);
            for (UploadImgInfo *info in array) {
                [formData appendPartWithFileData:info.file
                                            name:info.key
                                        fileName:info.fileName
                                        mimeType:@"image/jpeg"];
            }
            return;
        }
    }
    
    for (NSString *key in params) {
        id value = params[key];
        if ([value isKindOfClass:[NSData class]]) {
            [formData appendPartWithFileData:value
                                        name:key
                                    fileName:key
                                    mimeType:@"image/jpeg"];
        } else if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *_tempArray = (NSMutableArray*)value;
            [_tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSData *_data = obj;
                NSString *_key = [NSString stringWithFormat:@"attachment%lu",(unsigned long)idx];
                [formData appendPartWithFileData:_data
                                            name:_key
                                        fileName:[NSString stringWithFormat:@"%@.jpg",_key]
                                        mimeType:@"image/jpeg"];
            }];
        }
    }
}

#pragma mark - currentManger
+ (AFHTTPSessionManager *)currentManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [AFHTTPSessionManager manager];
        //指定 响应数据的解析格式--JSON
        manger.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        //请求超时时长
        manger.requestSerializer.timeoutInterval = 90;
//        manger.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    
    //请求头
//    NSMutableDictionary *_headerDic = [Networking getRequestHeader];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
//    for (NSString *key in _headerDic) {
//        [manger.requestSerializer setValue:_headerDic[key] forHTTPHeaderField:key];
//    }
    return manger;
}

// 请求头数据
//+ (NSMutableDictionary*)getRequestHeader
//{
//    NSString *user_id = [[UserInfoProperty getInstance].user_id encryptWithDes];
//    NSString *buid = [[NSString stringWithFormat:@"%@_%@", [UserInfoProperty getInstance].user_id, [UserInfoProperty getInstance].b_uid] encryptWithDes];
    
//    NSMutableDictionary *dic = [@{@"version":Version_iCard,
//                                  @"device":[CommonClass getCurrentDeviceModelCode],
//                                  @"os":@"0",
//                                  @"channel":[GlobalProperty getInstance].channel,
//                                  @"user_id":user_id,
//                                  @"udid":[CommonClass getIdfaString],
//                                  @"token":[UserInfoProperty getInstance].token,
//                                  @"buid":buid, //buid
//                                  @"cityid":[GlobalProperty getInstance].selectedCityCode,
//                                  @"connection":@"close",
//                                  @"ticket":[GlobalProperty getInstance].ticket
//                                  } mutableCopy];
//    return dic;
//}

//- (BOOL)checkToken:(NSDictionary *)result
//{
//    return YES;
//}

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
