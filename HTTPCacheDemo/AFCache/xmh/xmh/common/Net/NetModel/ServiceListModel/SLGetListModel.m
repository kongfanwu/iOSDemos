//
//  SLGetListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SLGetListModel.h"


@implementation SLGetListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"dList" : [SLDlistModel class]};
}


@end


@implementation SLDlistModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



