//
//  Networking.h
//  AFNtest
//
//  Created by caoyinliang on 16/5/6.
//  Copyright © 2016年 51credit.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EAFRequestMethod){
    EAFRequestMethod_Get,   // Get请求方式
    EAFRequestMethod_Post,  // Post请求方式
};

@interface Networking : NSObject

/**
 *  对外请求接口
 *  @param url           请求地址
 *  @param params        参数
 *  @param requsetMethod 请求方式
 *  @param success       是否成功
 *  @param fail          失败
 *  @return 对象
 */
+ (NSURLSessionDataTask*_Nullable)requestWithURL:(NSString *_Nullable)url
                                          params:(NSMutableDictionary *_Nullable)params
                                   requsetMethod:(EAFRequestMethod)requsetMethod
                                         success:(void (^_Nullable)(id _Nullable result))success
                                            fail:(void (^_Nullable)(id _Nullable errorresult))fail;
/**
 *  上传
 *  @param url              请求地址
 *  @param params           参数
 *  @param uploadProgress   进度回调
 *  @param success          成功回调
 *  @param fail             失败回调
 *  @return 对象
 */
+ (NSURLSessionDataTask *_Nullable)UploadWithURL:(NSString *_Nullable)url
                                          params:(NSMutableDictionary *_Nullable)params
                                        progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                                         success:(void (^_Nullable)(id _Nullable result))success
                                            fail:(void (^_Nullable)(id _Nullable errorresult))fail;
@end
