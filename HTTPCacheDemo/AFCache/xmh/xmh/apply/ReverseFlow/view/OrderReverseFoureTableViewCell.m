//
//  OrderReverseFoureTableViewCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "OrderReverseFoureTableViewCell.h"

@implementation OrderReverseFoureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _textView.delegate = self;
    _textView.layer.borderColor = kIm_Background_Color_c.CGColor;
    _textView.layer.borderWidth =1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _txtLable.hidden = NO;
    }else{
        _txtLable.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_OrderReverseFoureCellBlock) {
        _OrderReverseFoureCellBlock(textView.text);
    }
}
@end
