//
//  DaiFuWuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "DaiFuWuCell.h"

@implementation DaiFuWuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageview1.frame = CGRectMake(15, 15, 57, 57);
    _imageview1.backgroundColor = [UIColor darkGrayColor];
    
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
    
    _tishiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _tishiBtn.backgroundColor = [UIColor clearColor];
    [_tishiBtn addTarget:self action:@selector(tishiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_tishiBtn];
    
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.borderWidth = 1;
    _btn1.titleLabel.font = FONT_SIZE(13);
    [_btn1 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    [_btn1 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateHighlighted];
    _btn1.layer.borderColor = [kBackgroundColor CGColor];
    [_btn1 setTitle:@"开单" forState:UIControlStateNormal];
    [_btn1 setTitle:@"开单" forState:UIControlStateHighlighted];
    
    _btn2.layer.cornerRadius = 3;
    _btn2.layer.borderWidth = 1;
    _btn2.titleLabel.font = FONT_SIZE(13);
    [_btn2 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    [_btn2 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateHighlighted];
    _btn2.layer.borderColor = [kBackgroundColor CGColor];
    [_btn2 setTitle:@"修改" forState:UIControlStateNormal];
    [_btn2 setTitle:@"修改" forState:UIControlStateHighlighted];
    
}
- (void)reloadworkDaiFuWuCellFuWuNeiRong{
    _lb1.text = @"顾客姓名:";
    _lb2.text = @"预约时间:";
    _lb3.text = @"预约项目:";
    _lb4.text = @"剩余次数:";
    
    _lb5.text = @"张二狗张二狗张二狗";
    _lb6.text = @"享美会样板间张二狗";
    _lb7.text = @"张爱玲张二狗张二狗";
    _lb8.text = @"狗蛋张二狗张二狗";
    
    _lb9.text = @"平台提醒：顾客在阶段推荐购买顾客在阶段推荐购买顾客在阶段推荐购买";
    
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
    _line2.frame = CGRectMake(0, _lb9.bottom+15, SCREEN_WIDTH, 10);
    
    _tishiBtn.frame = _lb9.frame;
    
    _btn2.frame = CGRectMake(SCREEN_WIDTH - 62-15, _line1.top-10-30, 62, 30);
    _btn1.frame = CGRectMake(_btn2.left - 15-62, _line1.top-10-30, 62, 30);
}

- (void)reloadworkDaiFuWuCellXiaoShouNeiRong{
    _lb1.text = @"顾客姓名:";
    _lb2.text = @"卡项名称";
    _lb3.text = @"余额:";
    _lb4.text = @"面额:";
    
    _lb5.text = @"张二狗张二狗张二狗";
    _lb6.text = @" 123456789123张二狗";
    _lb7.text = @"2700元张二狗张二狗张二狗";
    _lb8.text = @"10000元张二狗张二狗张二狗";
    
    _lb9.text = @"平台提醒：该顾客XX卡余额已不足";
    
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
    _line2.frame = CGRectMake(0, _lb9.bottom+15, SCREEN_WIDTH, 10);
    
    _btn2.hidden = YES;
    _btn1.hidden = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)tishiClick{
    if (_click) {
        self.click();
    }
}
@end
