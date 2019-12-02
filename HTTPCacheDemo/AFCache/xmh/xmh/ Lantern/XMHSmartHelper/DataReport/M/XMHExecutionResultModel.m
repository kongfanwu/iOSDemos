//
//  XMHExecutionResultListModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHExecutionResultModel.h"
#import "XMHNoteCell.h"
#import "XMHReportCouponCell.h"
#import "XMHSubscribeCell.h"
#import "XMHCouponListModel.h"
#import "XMHCouponModel.h"
@implementation XMHExecutionResultModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"ticket_list" : [XMHCouponModel class],@"user_list":[GKGLHomeCustomerModel class]};
}

- (NSString *)cellIdentifier
{
     _executionType = [_track_method integerValue] + 2;
    if (_executionType == XMHResultOfExecutionTypeCoupon) {
        return NSStringFromClass([XMHReportCouponCell class]);
    } else if (_executionType == XMHResultOfExecutionTypeSubscribe){
        return NSStringFromClass([XMHSubscribeCell class]);
    } else {
        return NSStringFromClass([XMHNoteCell class]);
    }
}

@end

@implementation XMHExecutionResultListModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"list" : [XMHExecutionResultModel class]};
}


@end
