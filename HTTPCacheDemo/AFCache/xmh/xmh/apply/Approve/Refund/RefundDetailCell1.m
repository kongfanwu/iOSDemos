//
//  RefundDetailCell1.m
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundDetailCell1.h"
#import "RefundListModel.h"
@interface RefundDetailCell1 ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UILabel *lbRefund;
@property (weak, nonatomic) IBOutlet UITextField *tfActual;

@end

@implementation RefundDetailCell1
{
    RefundModel * _refundModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _tfActual.delegate = self;
    _tfActual.layer.borderWidth = 1;
    _tfActual.layer.borderColor = kColorE.CGColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateRefundDetailCell1Model:(RefundModel *)model
{
    _refundModel = model;
    _lbName.text = model.name;
    if ([model.type isEqualToString:@"sales"]) {
        _lbName.text = model.ordernum;
    }
    _lbNum.text = model.num.length > 0?model.num:@"1";
    if (model.quitNum && (model.quitNum.length > 0)) {
        _lbNum.text = model.quitNum.length > 0 ?model.quitNum:@"1";
    }
    if (model.paramValue.length > 0) {
       _lbRefund.text =model.paramValue;
    }else{
       _lbRefund.text =model.money;
    }
    
    _tfActual.text = model.actualValue;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    /** 判断输入实退金额不能大于九位数 */
    if (textField.text.length >9 || textField.text.integerValue < 0) {
//        [SVProgressHUD showErrorWithStatus:@"请输入整月的退款金额"];
        return;
    }
    _refundModel.actualValue = textField.text;
    if (_RefundDetailCell1Block) {
        _RefundDetailCell1Block(_refundModel);
    }
}
@end
