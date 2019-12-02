//
//  WorkChoiceCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "WorkChoiceCell.h"

@implementation WorkChoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _im1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    _im1.backgroundColor = [UIColor whiteColor];
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(13);
}
- (void)refreshWorkChoiceCell:(NSString *)str{
    _lb1.text = str;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15, (40 - _lb1.height)/2.0, _lb1.width, _lb1.height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
