//
//  XMHActionSendCouponErrorCell.m
//  xmh
//
//  Created by ald_ios on 2019/5/17.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHActionSendCouponErrorCell.h"
@interface XMHActionSendCouponErrorCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (strong, nonatomic)XMHCouponSendErrorModel * model;
@end
@implementation XMHActionSendCouponErrorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb1.font = _tf.font = _lb3.font = FONT_SIZE(13);
    _lb1.textColor =  _tf.textColor = _lb3.textColor = kColor9;
    _tf.placeholder = @"输入库存";
    _tf.delegate = self;
}
- (void)updateCellModel:(XMHCouponSendErrorModel *)model index:(NSInteger)index
{
    _model = model;
    if (index == 0) {
        _lb1.font = _tf.font = _lb3.font = FONT_SIZE(14);
        _lb1.textColor = _lb3.textColor = _tf.textColor = kColor3;
        _tf.userInteractionEnabled = NO;
    }else{
        _tf.userInteractionEnabled = YES;
    }
    _lb1.text = model.name;
    _tf.text = [NSString stringWithFormat:@"%@",model.remain_num];
    _lb3.text = [NSString stringWithFormat:@"%@",model.supply_num];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _model.remain_num = textField.text;
    if (_XMHActionSendCouponErrorCellBlock) {
        _XMHActionSendCouponErrorCellBlock(_model);
    }
}
@end
