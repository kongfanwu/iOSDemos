//
//  LTempModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LTempModel.h"

@implementation LTempModel
+ (instancetype)tempModelWithUserid:(NSString *)userid jis:(NSString *)jis joincode:(NSString *)joincode{
    LTempModel * model = [[LTempModel alloc] init];
    model.userid = userid;
    model.jis = jis;
    model.joincode = joincode;
    return model;
}
@end
