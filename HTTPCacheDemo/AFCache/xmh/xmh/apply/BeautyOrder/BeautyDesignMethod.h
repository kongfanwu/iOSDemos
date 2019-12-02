//
//  BeautyDesignMethod.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeautyDesignMethod : NSObject
+ (NSString *)returnNameWithly_type:(NSString *)ly_typeStr;

+ (NSString *)returnNameWithBeautyCardPropertyName:(NSString *)propertyname;

+ (NSInteger)returnJiangeValue:(NSString *)jiangeStr;

+ (NSInteger)returnWeekValue:(NSString *)weekStr;
+ (NSInteger)returnEnglishWeekValue:(NSString *)weekStrtr;

@end
