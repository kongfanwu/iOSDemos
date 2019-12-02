//
//  RefundPerformanceModel.m
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundPerformanceModel.h"

@implementation RefundPerformanceModel
+ (instancetype)createModelName:(NSString *)name Type:(NSInteger)type valueName:(NSString *)valueName
{
    RefundPerformanceModel * model = [[RefundPerformanceModel alloc] init];
    model.name = name;
    model.valueName = valueName;
    model.type = type;
    return model;
}
+ (instancetype)createModelName:(NSString *)name Type:(NSInteger)type valueName:(NSString *)valueName account:(NSString *)account
{
    RefundPerformanceModel * model = [[RefundPerformanceModel alloc] init];
    model.name = name;
    model.valueName = valueName;
    model.type = type;
    model.account = account;
    return model;
}
@end
