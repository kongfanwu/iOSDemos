//
//  ExpressListModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/4.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ExpressListModel.h"

@implementation ExpressListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [ExpressModel class]};
}
@end

@implementation ExpressModel

@end
