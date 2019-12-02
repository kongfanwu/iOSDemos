//
//  MzzChuFangXiangMuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzChuFangXiangMuCell.h"

@implementation MzzChuFangXiangMuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lb1.textColor = kLabelText_Commen_Color_6;
    _lb1.font = FONT_SIZE(13);
    _lb1.frame =CGRectMake(15,5,SCREEN_WIDTH/2.0-30, 30);
    
    CGFloat width = SCREEN_WIDTH/2.0/3.0;
    
    _lb4.textColor = kLabelText_Commen_Color_6;
    _lb4.font = FONT_SIZE(13);
    _lb4.textAlignment = NSTextAlignmentCenter;
    _lb4.frame =CGRectMake(SCREEN_WIDTH -width-15 ,5, width, 30);
    
    _lb3.textColor = kLabelText_Commen_Color_6;
    _lb3.font = FONT_SIZE(13);
    [_lb3 sizeToFit];
    _lb3.textAlignment = NSTextAlignmentCenter;
    _lb3.frame =CGRectMake(_lb4.left - width,5, width, 30);
    
    _lb2.textColor = kLabelText_Commen_Color_6;
    _lb2.font = FONT_SIZE(13);
    [_lb2 sizeToFit];
    _lb2.textAlignment = NSTextAlignmentCenter;
    _lb2.frame =CGRectMake(_lb3.left - width,5, width, 30);
}
- (void)refreshChufangGuiHuaXiangMuCell:(BeautyProjectModel*)model{
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"%@",@(model.num)];
    _lb3.text = [NSString stringWithFormat:@"¥%.2f",model.price * model.num];
    _lb4.text = [NSString stringWithFormat:@"%@ 分钟",@(model.shichang)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
