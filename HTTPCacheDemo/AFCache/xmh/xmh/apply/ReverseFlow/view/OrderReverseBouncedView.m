//
//  OrderReverseBouncedView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/13.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "OrderReverseBouncedView.h"

@implementation OrderReverseBouncedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.inputTextField.delegate = self;
    self.inputTextField.keyboardType = UIKeyboardTypeDefault;

    self.inputTextField.layer.borderColor = kIm_Background_Color_c.CGColor;
    self.inputTextField.layer.borderWidth =1.0;
}

- (void)refreashViewTitle:(NSString *)title left:(NSString *)left right:(NSString *)right{
    
    _titleLabel.text = title;
    [_closeButton setTitle:left forState:UIControlStateNormal];
    [_sureButton setTitle:right forState:UIControlStateNormal];

}

@end
