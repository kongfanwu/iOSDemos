//
//  MineCellModel.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/4/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MineCellModel.h"

@implementation MineCellModel
+ (instancetype)createModelWithTitle:(NSString *)title icon:(NSString *)iconStr
{
    return [self createModelWithTitle:title icon:iconStr class:nil];
}
+ (instancetype)createModelWithTitle:(NSString *)title icon:(NSString *)iconStr class:(Class)class
{
    MineCellModel * model = [[MineCellModel alloc] init];
    model.iconStr = iconStr;
    model.title = title;
    model.vcClass = class;
    return model;
}
+ (instancetype)createModelWithTitle:(NSString *)title icon:(NSString *)iconStr className:(NSString *)className;
{
    MineCellModel * model = [[MineCellModel alloc] init];
    model.iconStr = iconStr;
    model.title = title;
    model.className = className;
    return model;
}
@end
