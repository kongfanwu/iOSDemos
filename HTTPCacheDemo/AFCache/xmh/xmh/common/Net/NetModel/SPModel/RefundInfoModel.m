//
//  RefundInfoModel.m
//  xmh
//
//  Created by ald_ios on 2018/11/13.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundInfoModel.h"

@implementation RefundInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"approvalPerson" : [ApprovalInfo class],@"duplicatePerson" : [ApprovalInfo class]};
}
@end

@implementation ApprovalInfo
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
