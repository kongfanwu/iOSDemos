//
//  workCell2.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "workCell2.h"

@implementation workCell2{
    UIImage *_tempbiaoqian;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageview1.backgroundColor = [UIColor darkGrayColor];
    
    _lbTitle.textColor = kLabelText_Commen_Color_3;
    _lbTitle.font = FONT_BOLD_SIZE(15);
    
    _lbTime.textColor = [ColorTools colorWithHexString:@"#999999"];
    _lbTime.font = FONT_SIZE(13);
    
    _lineTop.backgroundColor = kBackgroundColor;
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_BOLD_SIZE(15);
    
    _lb2.textColor = kLabelText_Commen_Color_6;
    _lb2.font = FONT_SIZE(13);
    
    _lb3.textColor = kLabelText_Commen_Color_6;
    _lb3.font = FONT_SIZE(13);
    
    _lb4.textColor = kLabelText_Commen_Color_6;
    _lb4.font = FONT_SIZE(13);
    
    _lb5.textColor = kLabelText_Commen_Color_3;
    _lb5.font = FONT_BOLD_SIZE(13);
    
    _lb6.textColor = kLabelText_Commen_Color_6;
    _lb6.font = FONT_SIZE(13);
    
    _lb7.textColor = kLabelText_Commen_Color_6;
    _lb7.font = FONT_SIZE(13);
    
    _lb8.textColor = kLabelText_Commen_Color_6;
    _lb8.font = FONT_SIZE(13);
    
    _line1.backgroundColor = kBackgroundColor;
    
    _lb9.textColor = kLabelText_Commen_Color_3;
    _lb9.font = FONT_SIZE(11);
    
    _line2.backgroundColor = kBackgroundColor;
    
    _lb10.textColor = [UIColor whiteColor];
    _lb10.textAlignment = NSTextAlignmentCenter;
    _lb10.font = FONT_SIZE(10);
    
    _tempbiaoqian = [UIImage imageNamed:@"biaoqian"];
    _imageview2.image = _tempbiaoqian;
    
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.borderWidth = 1;
    _btn1.titleLabel.font = FONT_SIZE(13);
    [_btn1 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    [_btn1 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateHighlighted];
    _btn1.layer.borderColor = [kBackgroundColor CGColor];
    [_btn1 setTitle:@"驳回" forState:UIControlStateNormal];
    [_btn1 setTitle:@"驳回" forState:UIControlStateHighlighted];
    
    _btn2.layer.cornerRadius = 3;
    _btn2.layer.borderWidth = 1;
    _btn2.titleLabel.font = FONT_SIZE(13);
    [_btn2 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    [_btn2 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateHighlighted];
    _btn2.layer.borderColor = [kBackgroundColor CGColor];
    [_btn2 setTitle:@"同意" forState:UIControlStateNormal];
    [_btn2 setTitle:@"同意" forState:UIControlStateHighlighted];
}
- (void)reloadworkCell2TuiKuanShenQing{
    _lbTitle.text = @"顾客退款申请";
    _lbTime.text = @"12:20:2002";
    _lb1.text = @"发起人:";
    _lb2.text = @"所属门店:";
    _lb3.text = @"所属技师:";
    _lb4.text = @"顾客姓名:";
    
    _lb5.text = @"张二狗";
    _lb6.text = @"享美会样板间";
    _lb7.text = @"张爱玲";
    _lb8.text = @"狗蛋";
    
    _lb9.text = @"退款理由：项目做不了";
    _lb10.text = @"待审批";
    
    [_lbTitle sizeToFit];
    _lbTitle.frame =CGRectMake(15, 15, _lbTitle.width, _lbTitle.height);
    
    [_lbTime sizeToFit];
    _lbTime.frame =CGRectMake(_lbTime.left, 15, _lbTime.width, _lbTime.height);
    _lbTime.center = CGPointMake(_lbTime.centerX, _lbTitle.center.y);
    
    _lineTop.frame = CGRectMake(15, _lbTitle.bottom+15, SCREEN_WIDTH-30, 1);
    
    _imageview1.frame = CGRectMake(15, _lineTop.bottom+15, 57, 57);

    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_imageview1.right+10, _imageview1.top, _lb1.width, _lb1.height);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb2.width, _lb2.height);
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.left, _lb3.bottom+8, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb1.right+5, _lb1.top, _lb5.width, _lb5.height);
    
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb6.width, _lb6.height);
    
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb7.width, _lb7.height);
    
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb8.width, _lb8.height);
    
    _line1.frame = CGRectMake(_lb1.left, _lb8.bottom+9, SCREEN_WIDTH-_lb1.left - 15, 1);
    
    [_lb9 sizeToFit];
    _lb9.frame =CGRectMake(_lb1.left, _line1.bottom+15, SCREEN_WIDTH-_lb1.left - 15, _lb9.height);
    
    [_lb10 sizeToFit];
    _imageview2.frame = CGRectMake(SCREEN_WIDTH - 15 - _lb10.width-20, _imageview1.top, _lb10.width+20, _tempbiaoqian.size.height);
    _lb10.frame =_imageview2.frame;
    _lb10.center = CGPointMake(_imageview2.center.x+7, _imageview2.center.y);
    
    _line2.frame = CGRectMake(0, _lb9.bottom+15, SCREEN_WIDTH, 10);
        
    _btn2.frame = CGRectMake(SCREEN_WIDTH - 62-15, _line1.top-10-30, 62, 30);
    _btn1.frame = CGRectMake(_btn2.left - 15-62, _line1.top-10-30, 62, 30);
}
- (void)reloadworkCell2HuiYuanDongJie{
    _lbTitle.text = @"会员冻结会员冻结会员冻结会员冻结";
    _lbTime.text = @"9:20:201800000000000000";
    _lb1.text = @"发起人:";
    _lb2.text = @"所属门店:";
    _lb3.text = @"";
    _lb4.text = @"顾客姓名:";
    
    _lb5.text = @"张二狗会员冻结";
    _lb6.text = @"享美会样板间";
    _lb7.text = @"";
    _lb8.text = @"狗蛋会员冻结";
    
    _lb9.text = @"冻结理由：长期无消费服务";
    _lb9.text = @"";
    [_lb9 setHidden:YES];
    _lb10.text = @"审批中";
    
    [_lbTitle sizeToFit];
    _lbTitle.frame =CGRectMake(15, 15, _lbTitle.width, _lbTitle.height);
    
    [_lbTime sizeToFit];
    _lbTime.frame =CGRectMake(_lbTime.left - 80, 15, _lbTime.width, _lbTime.height);
    _lbTime.center = CGPointMake(_lbTime.centerX, _lbTitle.center.y);
    
    _lineTop.frame = CGRectMake(15, _lbTitle.bottom+15, SCREEN_WIDTH-30, 1);
    
    _imageview1.frame = CGRectMake(15, _lineTop.bottom+15, 57, 57);
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_imageview1.right+10, _imageview1.top, _lb1.width, _lb1.height);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb2.width, _lb2.height);
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.left, _lb3.bottom+8, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb1.right+5, _lb1.top, _lb5.width, _lb5.height);
    
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb6.width, _lb6.height);
    
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb7.width, _lb7.height);
    
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb8.width, _lb8.height);
    
    _line1.frame = CGRectMake(_lb1.left, _lb8.bottom+9, SCREEN_WIDTH-_lb1.left - 15, 1);
    
    [_lb9 sizeToFit];
    _lb9.frame =CGRectMake(_lb1.left, _line1.bottom+15, SCREEN_WIDTH-_lb1.left - 15, _lb9.height);
    
    [_lb10 sizeToFit];
    _imageview2.frame = CGRectMake(SCREEN_WIDTH - 15 - _lb10.width-20, _imageview1.top, _lb10.width+20, _tempbiaoqian.size.height);
    _lb10.frame =_imageview2.frame;
    _lb10.center = CGPointMake(_imageview2.center.x+7, _imageview2.center.y);
    
    _line2.frame = CGRectMake(0, _lb9.bottom+15, SCREEN_WIDTH, 10);
    NSLog(@"%f",_line2.bottom);
    _btn2.frame = CGRectMake(SCREEN_WIDTH - 62-15, _line1.top-10-30, 62, 30);
    _btn1.hidden = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
