//
//  LOrderYejiListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/2.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LOrderYejiListModel.h"

@implementation LOrderYejiListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [LOrderYejiModel class]};
}
@end

@implementation LOrderYejiModel

@end
