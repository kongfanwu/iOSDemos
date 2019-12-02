//
//  MzzFilterTbSectionHeaderViewTextfiled.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzFilterTbSectionHeaderViewTextfiled.h"
@interface MzzFilterTbSectionHeaderViewTextfiled ()<UITextFieldDelegate>
@end
@implementation MzzFilterTbSectionHeaderViewTextfiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    _tf1.delegate = self;
    _tf2.delegate = self;
    _tf1.keyboardType = UIKeyboardTypeDefault;
    _tf2.keyboardType = UIKeyboardTypeDefault;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_tf1.text.length > 0 &&_tf2.text.length >0) {
        if (_MzzFilterTbSectionHeaderViewTextfiledBlock) {
            _MzzFilterTbSectionHeaderViewTextfiledBlock(_lb.text,_tf1.text,_tf2.text);
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
