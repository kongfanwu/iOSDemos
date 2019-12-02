//
//  RefundLeftCellModel.m
//  xmh
//
//  Created by ald_ios on 2018/11/9.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundLeftCellModel.h"

@implementation RefundLeftCellModel
+ (instancetype)createModelTitle:(NSString *)title type:(NSString *)type
{
    RefundLeftCellModel * model = [[RefundLeftCellModel alloc] init];
    model.title = title;
    model.type = type;
    return model;
}
+ (instancetype)createModelTitle:(NSString *)title type:(NSString *)type selected:(BOOL)selected
{
    RefundLeftCellModel * model = [[RefundLeftCellModel alloc] init];
    model.title = title;
    model.type = type;
    model.selected = selected;
    return model;
}
@end
