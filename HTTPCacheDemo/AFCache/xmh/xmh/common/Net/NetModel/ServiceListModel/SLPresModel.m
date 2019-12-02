//
//  SLPresModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLPresModel.h"


@implementation SLPresModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SLPresListModel class]};
}


@end


@implementation SLPresListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pro_list" : [Pro_List class]};
}


@end


@implementation Pro_List


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



