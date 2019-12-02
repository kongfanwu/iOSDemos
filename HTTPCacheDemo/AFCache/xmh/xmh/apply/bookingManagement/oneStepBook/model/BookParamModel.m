//
//  BookParamModel.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookParamModel.h"

@implementation BookParamModel
+ (instancetype)createBookParamModelVCTitle:(NSString *)title type:(NSString *)type orderNum:(NSString *)orderNum userID:(NSString *)userID
{
    BookParamModel * model = [[BookParamModel alloc] init];
    model.vcTitle = title;
    model.type = type;
    model.orderNum = orderNum;
    model.userID = userID;
    return model;
}
@end
