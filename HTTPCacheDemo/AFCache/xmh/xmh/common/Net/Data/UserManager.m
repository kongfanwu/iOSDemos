//
//  UserManager.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "UserManager.h"
static UserManager * shareUserManager;
@implementation UserManager
+ (UserManager *)shareUserManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserManager=[[UserManager alloc] init];
    });
    return shareUserManager;
}
+(void)releaseInstance{
    if (shareUserManager) {
        shareUserManager = nil;
    }
}
//设置NSObject型本地数据
+(void)setObjectUserDefaults:(id)value key:(NSString*)key 
{
    NSUserDefaults *objDefault = [NSUserDefaults standardUserDefaults];
    if (objDefault){
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [objDefault setObject:data forKey:key];
        [objDefault synchronize];
    }
}

//获得NSObject型本地数据
+(id)getObjectUserDefaults:(NSString*)key
{
    id object = nil;
    NSUserDefaults *objDefault = [NSUserDefaults standardUserDefaults];
    
    if (objDefault){
        NSData *data = [objDefault objectForKey:key];
        if (data != nil) {
            @try {
                object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                return object;
            }
            @catch (NSException *exception) {
                return object;
            }
            @finally {
            
            }
        }
    }
    return object;
}

//设置NSMutableArray型本地数据
+ (void)setArrayUserDefaults:(NSMutableArray*)value key:(NSString*)key
{
    NSUserDefaults *arrayDefault = [NSUserDefaults standardUserDefaults];
    if (arrayDefault){
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [arrayDefault setObject:data forKey:key];
        [arrayDefault synchronize];
    }
}

//获得NSMutableArray型本地数据
+ (NSMutableArray*)getArrayUserDefaults :(NSString*)key
{
    NSMutableArray *array = nil;
    NSUserDefaults *arrayDefault = [NSUserDefaults standardUserDefaults];
    
    if (arrayDefault){
        NSData *data = [arrayDefault objectForKey:key];
        if (data != nil) {
            array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return array;
}
@end
