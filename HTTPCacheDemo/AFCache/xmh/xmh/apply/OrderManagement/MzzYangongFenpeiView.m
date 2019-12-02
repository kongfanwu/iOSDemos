//
//  MzzYangongFenpeiView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzYangongFenpeiView.h"
@interface MzzYangongFenpeiView()<UITextFieldDelegate>
@end
@implementation MzzYangongFenpeiView
-(void)awakeFromNib{
    [super awakeFromNib];
    _shuruLbl.delegate = self;
    _shuruLbl.keyboardType = UIKeyboardTypeDefault;
}

-(void)setJishiModel:(MLJiShiModel *)jishiModel{
    _jishiModel = jishiModel;
    [_nameLbl setText:_jishiModel.name];
    if (_jishiModel.bfb == 0.00) {
        [_shuruLbl setText:[NSString stringWithFormat:@"%.0f",_jishiModel.bfb]];
    }else{
        [_shuruLbl setText:[NSString stringWithFormat:@"%.2f",_jishiModel.bfb]];
    }
}
- (IBAction)deleteBtn:(UIButton *)sender {
    self.deleteClick(self.tag);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.value(textField.text.integerValue, _jishiModel,textField);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _shuruLbl.text = nil;
    return YES;
}
@end
