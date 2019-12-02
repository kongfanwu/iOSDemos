//
//  LFileManager.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFileManager.h"

@implementation LFileManager
+ (CGFloat)getCacheSize{
    LFileManager * fileM = [[LFileManager alloc] init];
    return  [fileM filePath];
}
- (CGFloat)filePath
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    return [ self folderSizeAtPath :cachPath];
}
- (CGFloat)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}
- (CGFloat)folderSizeAtPath:( NSString *)folderPath
{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
}
+ (void)clearCacheresultBlock:(void(^)(BOOL isSuccess))resultBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
        NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
        for ( NSString * p in files) {
            NSError * error = nil ;
            NSString * path = [cachPath stringByAppendingPathComponent :p];
            if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
                [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            }
        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            resultBlock(YES);
        });
    });
}
@end
