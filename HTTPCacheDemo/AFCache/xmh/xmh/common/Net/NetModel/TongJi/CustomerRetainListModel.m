//
//  CustomerRetainListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerRetainListModel.h"

@implementation CustomerRetainListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"next" : [CustomerRetainModel class]};
}
@end

@implementation CustomerRetainModel

@end
