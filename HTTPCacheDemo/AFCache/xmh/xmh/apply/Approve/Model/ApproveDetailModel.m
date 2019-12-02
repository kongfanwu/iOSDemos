//
//  ApproveDetailModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ApproveDetailModel.h"

@implementation ApproveDetailModel
+ (instancetype)initWithToken:(NSString *)token joinCode:(NSString *)joinCode code:(NSString *)code accountId:(NSString *)accountId url:(NSString *)urlStr navTitle:(NSString *)navTitle from:(NSString *)from ordernum:(NSString *)ordernum fromList:(BOOL)fromList
{
    ApproveDetailModel * model = [[ApproveDetailModel alloc] init];
    model.join_code = joinCode;
    model.token = token;
    model.code = code;
    model.urlstr = urlStr;
    model.accountId = accountId;
    model.navTitle = navTitle;
    model.from = from;
    model.ordernum = ordernum;
    model.fromList = fromList;
    return model;
}
@end
