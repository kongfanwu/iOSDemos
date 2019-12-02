//
//  OrderReverseThreeTableViewCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "OrderReverseThreeTableViewCell.h"
#import "RestrictionInput.h"

@implementation OrderReverseThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _phoneTextField.layer.borderColor = kIm_Background_Color_c.CGColor;
    _phoneTextField.layer.borderWidth =1.0;
    _phoneTextField.delegate = self;
    
//    _guishuLable.layer.borderColor = kIm_Background_Color_c.CGColor;
//    _guishuLable.layer.borderWidth =1.0;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.phoneTextField) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.phoneTextField.text.length >= 11) {
            self.phoneTextField.text = [textField.text substringToIndex:11];
            return NO;
        }
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_OrderReverseThreeCellBlock) {
        _OrderReverseThreeCellBlock(textField.text);
    }
}
-(void)updateGuishu:(NSString *)guishu
{
    if (guishu.length == 0) {
        self.guishuLable.text = @"请选择";
    }else{
        self.guishuLable.text = guishu;
    }
}
- (IBAction)chooseButton:(id)sender {
    if (_chooseCellBlock) {
        _chooseCellBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
