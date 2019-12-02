//
//  LApproveModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveModel.h"

@implementation LApproveModel
+ (instancetype)modelTitle:(NSString *)title imgName:(NSString *)imgName
{
    LApproveModel * model = [[LApproveModel alloc] init];
    model.title = title;
    model.imgName = imgName;
    return model;
}
@end
