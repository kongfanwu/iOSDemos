//
//  RefundDetailCell2.m
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundDetailCell2.h"
#import "RefundPerformanceModel.h"
@interface RefundDetailCell2 ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnMinus;
@property (weak, nonatomic) IBOutlet UILabel *lbUnit;

@property (weak, nonatomic) IBOutlet UITextField *tfInPut;

@end
@implementation RefundDetailCell2
{
    RefundPerformanceModel * _refundPerformanceModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _tfInPut.layer.borderWidth = 1;
    _tfInPut.layer.borderColor = kColorE.CGColor;
    _tfInPut.delegate = self;
    /** 默认全部隐藏 */
    _btnSelect.hidden = YES;
    _lbValue.hidden = YES;
    _btnAdd.hidden = YES;
    _btnMinus.hidden = YES;
    _lbUnit.hidden = YES;
    _tfInPut.hidden = YES;
}
- (void)updateRefundDetailCell2Model:(RefundPerformanceModel *)model
{
    _refundPerformanceModel = model;
    /** 业绩归属 */
    if (model.type == 1) {
        _btnSelect.hidden = NO;
    }
    /** 门店归属 */
    if (model.type == 2) {
        _lbValue.hidden = NO;
    }
    /** 店长归属 */
    if (model.type == 3) {
        _btnSelect.hidden = NO;
    }
    /** 员工归属 */
    if (model.type == 4) {
        _btnAdd.hidden = NO;
    }
    /** 公共业绩 */
    if (model.type == 5) {
        _tfInPut.hidden = NO;
        _lbUnit.hidden = NO;
    }
    /** 所选技师 */
    if (model.type == 6) {
        _tfInPut.hidden = NO;
        _lbUnit.hidden = NO;
        _btnMinus.hidden = NO;
    }
    _lbName.text = model.name;
    _lbValue.text = model.valueName;
    if (model.valueName.length > 0) {
        [_btnSelect setTitle:@"" forState:UIControlStateNormal];
        _lbValue.hidden = NO;
        _lbValue.text = model.valueName;
    }
    _tfInPut.text = model.valueInput;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _refundPerformanceModel.valueInput = textField.text;
    if (_RefundDetailCell2InputBlock) {
        _RefundDetailCell2InputBlock(_refundPerformanceModel);
    }
}
/** 加号按钮点击 */
- (IBAction)btnAddClick:(id)sender
{
    if (_RefundDetailCell2AddBlock) {
        _RefundDetailCell2AddBlock(_refundPerformanceModel);
    }
}
/** 叉号点击 */
- (IBAction)btnMinusClick:(id)sender
{
    if (_RefundDetailCell2MinusBlock) {
        _RefundDetailCell2MinusBlock(_refundPerformanceModel);
    }
}
/** 右箭头按钮点击 */
- (IBAction)btnSelectClick:(id)sender
{
    if (_RefundDetailCell2SelectBlock) {
        _RefundDetailCell2SelectBlock(_refundPerformanceModel);
    }
}
@end
