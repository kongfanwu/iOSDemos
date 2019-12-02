//
//  LTempModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTempModel : NSObject
@property (nonatomic, copy)NSString * userid;
@property (nonatomic, copy)NSString * jis;
@property (nonatomic, copy)NSString * joincode;
+ (instancetype)tempModelWithUserid:(NSString *)userid jis:(NSString *)jis joincode:(NSString *)joincode;
@end
