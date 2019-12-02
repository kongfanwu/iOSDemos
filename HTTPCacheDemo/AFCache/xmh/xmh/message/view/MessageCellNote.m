//
//  MessageCellNote.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/9.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MessageCellNote.h"
#import "XMHBadgeLabel.h"
@implementation MessageCellNote

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageview1.frame = CGRectMake(15, 15, 10, 10);
//    _imageview1.layer.cornerRadius = 5;
//    _imageview1.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
    
    _lb1.text = @"通知通知通知";
    _lb1.font = FONT_BOLD_SIZE(18);
    _lb1.textColor = kLabelText_Commen_Color_3;
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(_imageview1.right+6, 12, _lb1.width, _lb1.height);
    
    _lb2.text = @"周报数据报表统计";
    _lb2.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_6;
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_imageview1.right+6, _lb1.bottom+10, SCREEN_WIDTH - 30, _lb2.height);
    
    _lb3.text = @"2016-01-15";
    _lb3.font = FONT_SIZE(14);
    _lb3.textColor = [ColorTools colorWithHexString:@"#999999"];
    [_lb3 sizeToFit];
    
    _lb4.text = @"09:30";
    _lb4.font = FONT_SIZE(14);
    _lb4.textColor = [ColorTools colorWithHexString:@"#999999"];
    [_lb4 sizeToFit];
    
    
    //
    _lb3.frame = CGRectMake(SCREEN_WIDTH - 15 - _lb4.width - 6 - _lb3.width, 16, _lb3.width, _lb3.height);
    _lb4.frame = CGRectMake(SCREEN_WIDTH - 15 - _lb4.width, 16, _lb4.width, _lb4.height);
    
    _line.frame = CGRectMake(0, 76, SCREEN_WIDTH, 10);
    _line.backgroundColor = kBackgroundColor;
    
    _badgeLabel = [XMHBadgeLabel defaultBadgeLabel];
    _badgeLabel.backgroundColor = [ColorTools colorWithHexString:@"#f10180"];
    _badgeLabel.text = @"999+";
    _badgeLabel.right = SCREEN_WIDTH -15;
    _badgeLabel.bottom = _lb2.bottom;
    _badgeLabel.height = 16;
    [self.contentView addSubview:_badgeLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
