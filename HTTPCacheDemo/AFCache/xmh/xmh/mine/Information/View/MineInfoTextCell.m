//
//  MineInfoTextCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/15.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MineInfoTextCell.h"
@interface MineInfoTextCell()<UITextFieldDelegate>

@end

@implementation MineInfoTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _tfContent.textColor = [ColorTools colorWithHexString:@"333333"];
    // Initialization code
    _tfContent.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_MineInfoTextCellBlockBlock) {
        _MineInfoTextCellBlockBlock(textField.text);
    }
}
@end
