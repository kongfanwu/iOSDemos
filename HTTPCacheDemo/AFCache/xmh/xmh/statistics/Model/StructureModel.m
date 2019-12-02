//
//  StructureModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "StructureModel.h"

@implementation StructureModel
+ (instancetype)initWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId startTime:(NSString *)startTime endTime:(NSString *)endTime urlStr:(NSString *)urlStr token:(NSString *)token joinCode:(NSString *)joinCode type:(NSInteger)type
{
    StructureModel * model = [[StructureModel alloc] init];
    model.oneClick = oneClick;
    model.twoClick = twoClick;
    model.twoListId = twoListId;
    model.inId = inId;
    model.startTime = startTime;
    model.endTime = endTime;
    model.token = token;
    model.urlStr = urlStr;
    model.joinCode = joinCode;
    model.type = type;
    return model;
}
@end
