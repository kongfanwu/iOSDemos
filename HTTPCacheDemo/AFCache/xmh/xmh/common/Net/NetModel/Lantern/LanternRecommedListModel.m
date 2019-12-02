//
//  LanternRecommedListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternRecommedListModel.h"

@implementation LanternRecommedListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [LanternRecommedModel class]};
}
@end
@implementation LanternRecommedModel

@end
