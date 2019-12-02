//
//  LYuanGongSubCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LYuanGongSubCell.h"
#import "LolHomeModel.h"
@implementation LYuanGongSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb1.font =FONT_BOLD_SIZE(15);
    _lb1.textColor = kLabelText_Commen_Color_3;
    
    _lb2.font = FONT_SIZE(11);
    _lb2.textColor = kLabelText_Commen_Color_9;
    
    _lb3.font = FONT_SIZE(12);
    _lb3.textColor = kLabelText_Commen_Color_9;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LGuKeDetail *)model
{
    _lb1.text = model.user_name;
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    
    _lb2.text = model.pro_name;
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_lb1.left, _lb1.bottom + 12, _lb2.width, _lb2.height);
    
    _btn1.frame = CGRectMake(SCREEN_WIDTH - 15 - 15, (self.height - 15)/2, 8, 15);
    
    _lb3.text = model.day;
    [_lb3 sizeToFit];
    _lb3.frame = CGRectMake(_btn1.left - _lb3.width - 35, 16, _lb3.width, _lb3.height);
}

@end
