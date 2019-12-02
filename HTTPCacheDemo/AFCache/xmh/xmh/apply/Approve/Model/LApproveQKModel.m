//
//  LApproveQKModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/7.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveQKModel.h"

@implementation LApproveQKModel
+ (instancetype)createModelWithUserId:(NSString *)userId joinCode:(NSString *)joinCode storeCode:(NSString *)storeCode
{
    LApproveQKModel * model = [[LApproveQKModel alloc] init];
    model.userId = userId;
    model.joinCode = joinCode;
    model.storeCode = storeCode;
    return model;
}
@end
