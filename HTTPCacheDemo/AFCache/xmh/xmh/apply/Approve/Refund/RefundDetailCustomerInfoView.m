//
//  RefundDetailCustomerInfoView.m
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundDetailCustomerInfoView.h"
#import "RefundInfoModel.h"
@interface RefundDetailCustomerInfoView ()
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *lb;
/** 顾客姓名 手机号 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;

@end

@implementation RefundDetailCustomerInfoView

- (void)updateRefundDetailCustomerInfoViewModel:(RefundInfoModel *)model
{
    _lb.text = @"顾客姓名";
    _lb1.text = [NSString stringWithFormat:@"%@ （%@）",model.name,model.mobile];
}
@end
