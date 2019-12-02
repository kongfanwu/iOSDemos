//
//  MzzWordManagerModel.m
//  xmh
//
//  Created by Ss H on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzWordManagerModel.h"

@implementation MzzWordManagerModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [MzzManageModel class]};
}


@end

@implementation MzzManageModel


@end
