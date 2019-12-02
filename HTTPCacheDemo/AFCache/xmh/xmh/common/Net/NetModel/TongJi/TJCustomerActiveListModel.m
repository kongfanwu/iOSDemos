//
//  TJCustomerActiveListModel.m
//  xmh
//
//  Created by ald_ios on 2018/12/10.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJCustomerActiveListModel.h"

@implementation TJCustomerActiveListModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [TJCustomerActiveModel class]};
}
@end

@implementation TJCustomerActiveModel

@end
