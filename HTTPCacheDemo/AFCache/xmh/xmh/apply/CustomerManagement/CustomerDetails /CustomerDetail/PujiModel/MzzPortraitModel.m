//
//  MzzPortraitModel.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPortraitModel.h"

@implementation MzzPortraitModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [MzzPortraitModell class]};
}
@end
@implementation MzzPortraitModell

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"content_list" : [MzzPortraitListModel class]};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end

@implementation MzzPortraitListModel

@end
