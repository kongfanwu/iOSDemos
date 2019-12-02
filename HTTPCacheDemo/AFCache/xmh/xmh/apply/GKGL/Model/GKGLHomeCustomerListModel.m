//
//  GKGLHomeCustomerListModel.m
//  xmh
//
//  Created by ald_ios on 2019/1/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHomeCustomerListModel.h"

@implementation GKGLHomeCustomerListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [GKGLHomeCustomerModel class]};
}
@end

@implementation GKGLHomeCustomerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"uid" :@"id"};
}
@end
