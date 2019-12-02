//
//  UserManager.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LolUserInfoModel.h"

@interface UserManager : NSObject
+ (UserManager *)shareUserManager;
/**
 *  设置NSObject型本地数据
 */
+(void)setObjectUserDefaults:(id)value key:(NSString*)key;

/**
 *  获得NSObject型本地数据
 */
+(id)getObjectUserDefaults:(NSString*)key;

/**
 *  设置NSMutableArray型本地数据
 */
+ (void)setArrayUserDefaults:(NSMutableArray*)value key:(NSString*)key;

/**
 *  获得NSMutableArray型本地数据
 */
+ (NSMutableArray*)getArrayUserDefaults :(NSString*)key;
+(void)releaseInstance;
@end
