//
//  SAZhiHuanPorListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SAZhiHuanPorListModel.h"

@implementation SAZhiHuanPorListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [SAZhiHuanPorModel class]};
}
@end

@implementation SAZhiHuanPorModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
