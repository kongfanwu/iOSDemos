//
//  MStoreListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/30.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MStoreListModel.h"

@implementation MStoreListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [MStoreModel class]};
}
@end


@implementation MStoreModel

@end
