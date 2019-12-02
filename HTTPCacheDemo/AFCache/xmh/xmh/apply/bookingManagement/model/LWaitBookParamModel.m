//
//  LWaitBookParamModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LWaitBookParamModel.h"

@implementation LWaitBookParamModel
+ (instancetype)createModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId joinCode:(NSString *)joinCode inId:(NSString *)inId{
    LWaitBookParamModel * model = [[LWaitBookParamModel alloc] init];
    model.oneClick = oneClick;
    model.twoClick = twoClick;
    model.twoListId = twoListId;
    model.joinCode = joinCode;
    model.inId = inId;
    return model;
}
@end
