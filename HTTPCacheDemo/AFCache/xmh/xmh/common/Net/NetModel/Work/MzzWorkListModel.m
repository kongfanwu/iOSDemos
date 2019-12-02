//
//  MzzWorkListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzWorkListModel.h"

@implementation MzzWorkListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [MzzWork class]};
}


@end

@implementation MzzWork


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



