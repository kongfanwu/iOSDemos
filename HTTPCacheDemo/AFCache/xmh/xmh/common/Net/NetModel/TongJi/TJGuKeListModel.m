//
//  TJGuKeListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeListModel.h"

@implementation TJGuKeListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJGuKeSubModel class],@"hydj":[TJGuKeClassModel class]};
}
@end

@implementation TJGuKeClassModel

@end


@implementation TJGuKeSubModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
