//
//  MineInfoLocalModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MineInfoLocalModel.h"

@implementation MineInfoLocalModel
+ (instancetype)initWithTitle:(NSString *)title content:(NSString *)content isShow:(BOOL)isShow{
    MineInfoLocalModel * model = [[MineInfoLocalModel alloc] init];
    model.title = title;
    model.content = content;
    model.isShow = isShow;
    return model;
}
@end
