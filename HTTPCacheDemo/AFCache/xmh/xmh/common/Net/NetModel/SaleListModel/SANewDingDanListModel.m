//
//  SANewDingDanListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SANewDingDanListModel.h"

@implementation SANewDingDanListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SANewDingDanModel class]};
}
@end

@implementation SANewDingDanModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end
