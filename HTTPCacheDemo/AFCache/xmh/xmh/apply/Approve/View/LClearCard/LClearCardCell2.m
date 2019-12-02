//
//  LClearCardCell2.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LClearCardCell2.h"
@interface LClearCardCell2 ()<UITextViewDelegate>
@end
@implementation LClearCardCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _tf1.delegate = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _lb1.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length > 0) {
        if (_LClearCardCell2Block) {
            _LClearCardCell2Block(textView.text);
        }
    }
}
@end
