//
//  XFYDtbSectionHeaderModel.m
//  xmh
//
//  Created by ald_ios on 2018/10/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XFYDtbSectionHeaderModel.h"
@interface XFYDtbSectionHeaderModel ()
@end
@implementation XFYDtbSectionHeaderModel
+ (instancetype)createModelLeftName:(NSString *)leftName middleName:(NSString *)middleName rightName:(NSString *)rightName
{
    XFYDtbSectionHeaderModel * model = [[XFYDtbSectionHeaderModel alloc] init];
    model.leftName = leftName;
    model.middleName = middleName;
    model.rightName = rightName;
    return model;
}
@end
