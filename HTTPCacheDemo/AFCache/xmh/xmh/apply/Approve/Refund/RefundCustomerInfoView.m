//
//  RefundCustomerInfoView.m
//  xmh
//
//  Created by ald_ios on 2018/11/7.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundCustomerInfoView.h"
#import "RefundInfoModel.h"
@interface RefundCustomerInfoView ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UISwitch *swAll;

@end

@implementation RefundCustomerInfoView
- (void)updateRefundCustomerInfoViewModel:(RefundInfoModel*)model
{
    _lbName.text = @"顾客姓名";
    _lbPhone.text = [NSString stringWithFormat:@"%@ %@",model.name,model.mobile];
}
- (IBAction)change:(UISwitch *)sender {
    if (sender.on) {
        _lb.text = @"是";
    }else{
        _lb.text = @"否";
    }
    if (_RefundCustomerInfoViewBlock) {
        _RefundCustomerInfoViewBlock(sender.on);
    }
}
- (void)updateRefundCustomerInfoViewSwitchState:(BOOL)off
{
    _swAll.on = off;
    _lb.text = @"否";
}
@end
