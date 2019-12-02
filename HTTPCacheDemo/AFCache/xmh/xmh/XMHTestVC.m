//
//  XMHTestVC.m
//  xmh
//
//  Created by KFW on 2019/5/24.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTestVC.h"
#import "XMHPerson.h"
#import "XMHSearchView.h"
#import "AFImageDownloader.h"

@interface XMHTestVC ()

/** <##> */
@property (nonatomic, strong) XMHPerson *obj, *obj2;
@end

@implementation XMHTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];
    
    XMHPerson *obj = XMHPerson.new;
    self.obj = obj;
    obj.name = self;
    XMHPerson *obj2 = [obj mutableCopy];
    self.obj2 = obj2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       NSLog(@"%@", obj2);
    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test];
    return;
    AFHTTPSessionManager *manager;
//    = [AFHTTPSessionManager manager];
    manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[self.class defaultURLSessionConfiguration]];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadRevalidatingCacheData;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",nil];
    [manager GET:@"http://127.0.0.1:5000/"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"allHTTPHeaderFields:%@", task.currentRequest.allHTTPHeaderFields);
             NSHTTPURLResponse *hTTPURLResponse = ((NSHTTPURLResponse *)task.response);
             NSLog(@"%@", hTTPURLResponse.allHeaderFields);
             NSLog(@"%ld", hTTPURLResponse.statusCode);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
         }];
}
+ (NSURLCache *)defaultURLCache {
    // It's been discovered that a crash will occur on certain versions
    // of iOS if you customize the cache.
    //
    // More info can be found here: https://devforums.apple.com/message/1102182#1102182
    //
    // When iOS 7 support is dropped, this should be modified to use
    // NSProcessInfo methods instead.
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.2" options:NSNumericSearch] == NSOrderedAscending) {
        return [NSURLCache sharedURLCache];
    }
    return [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                         diskCapacity:150 * 1024 * 1024
                                             diskPath:@"com.alamofire.imagedownloader"];
}

/*
 NSURLRequestUseProtocolCachePolicy NSURLRequest 默认的cache policy，使用Protocol协议定义。
 NSURLRequestReloadIgnoringCacheData 忽略缓存，直接从原始地址下载，用于实时数据。
 NSURLRequestReturnCacheDataDontLoad 只使用cache数据，如果不存在cache，请求失败；用于没有建立网络连接离线模式。
 NSURLRequestReturnCacheDataElseLoad 只有在cache中不存在data时才从原始地址下载，适用一些不太会变化的数据。
 注意以下策略是未实现的：
 
 NSURLRequestReloadIgnoringLocalAndRemoteCacheData 忽略本地和远程的缓存数据，直接从原始地址下载，与NSURLRequestReloadIgnoringCacheData类似。
 NSURLRequestReloadRevalidatingCacheData 验证本地数据与远程数据是否相同，如果不同则下载远程数据，否则使用本地数据。
 */
+ (NSURLSessionConfiguration *)defaultURLSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //TODO set the default HTTP headers
    
    configuration.HTTPShouldSetCookies = YES;
    configuration.HTTPShouldUsePipelining = NO;
    
//    configuration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    // 2.设置缓存策略(有缓存就用缓存，没有缓存就重新请求)
    configuration.requestCachePolicy = NSURLRequestReturnCacheDataDontLoad;
    configuration.allowsCellularAccess = YES;
    configuration.timeoutIntervalForRequest = 60.0;
    configuration.URLCache = [AFImageDownloader defaultURLCache];
    
    return configuration;
}

- (void)test {
    /*
     Cache-Control'] = 'max-age=30'
     [req addValue:@"Thu, 19 Sep 2019 10:18:01 GMT" forHTTPHeaderField:@"If-Modified-Since"];
     */
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:5000/"]];
    req.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    // Last-Modified/If-Modified-Since
    [req addValue:@"Thu, 19 Sep 2019 10:18:01 GMT" forHTTPHeaderField:@"If-Modified-Since"];
    // Etag/If-None-Match
    [req addValue:@"123456" forHTTPHeaderField:@"If-None-Match"];
    
  
//    NSURLCache *cache = [NSURLCache sharedURLCache];
//    NSCachedURLResponse *res = [cache cachedResponseForRequest:req];
//    NSLog(@"%@", res);
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
        NSLog(@"%@", ((NSHTTPURLResponse *)response).allHeaderFields);
        NSLog(@"statusCode:%ld", ((NSHTTPURLResponse *)response).statusCode);
    }];
    
}

@end
