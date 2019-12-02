//
//  FWDCommentCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDCommentCell.h"
@interface FWDCommentCell()<UITextViewDelegate>
@end
@implementation FWDCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _textView.delegate = self;
    _textView.layer.borderColor = kIm_Background_Color_c.CGColor;
    _textView.layer.borderWidth =1.0;
    _textView.layer.cornerRadius =5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (!_isNewVersion) {
        if (textView.text.length == 0) {
            _lb1.hidden = NO;
        }else{
            _lb1.hidden = YES;
        }        
    }
    _lbLimit.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_FWDCommentCellBlock) {
        _FWDCommentCellBlock(textView.text);
    }
}
@end
