//
//  workCell1.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "workCell1.h"

@implementation workCell1{
    UIImage *_tempbiaoqian;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageview1.frame = CGRectMake(15, 15, 57, 57);
    _imageview1.backgroundColor = [UIColor darkGrayColor];
    _imageview1.layer.masksToBounds = YES;
    _imageview1.layer.cornerRadius =3;
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_BOLD_SIZE(15);
    
    _lb2.textColor = kLabelText_Commen_Color_9;
    _lb2.font = FONT_SIZE(13);
    
    _lb3.textColor = kLabelText_Commen_Color_9;
    _lb3.font = FONT_SIZE(13);
    
    _lb4.textColor = kLabelText_Commen_Color_3;
    _lb4.font = FONT_BOLD_SIZE(15);
    
    _lb5.textColor = kLabelText_Commen_Color_9;
    _lb5.font = FONT_SIZE(13);
    
    _lb6.textColor = kLabelText_Commen_Color_9;
    _lb6.font = FONT_SIZE(13);
    
    _tempbiaoqian = [UIImage imageNamed:@"biaoqian"];
    _imageview2.image = _tempbiaoqian;
    
    _lb7.textColor = [UIColor whiteColor];
    _lb7.textAlignment = NSTextAlignmentCenter;
    _lb7.font = FONT_SIZE(10);
    _btn1.frame = CGRectMake(SCREEN_WIDTH - 80-15, 15, 80, 30);
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.borderWidth = 1;
    _btn1.titleLabel.font = FONT_SIZE(13);
    [_btn1 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    [_btn1 setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateHighlighted];
    _btn1.layer.borderColor = [kBackgroundColor CGColor];
    [_btn1 setTitle:@"生成预约" forState:UIControlStateNormal];
    [_btn1 setTitle:@"生成预约" forState:UIControlStateHighlighted];
    
    _imageview3.frame = CGRectMake(15, _imageview1.bottom+15, SCREEN_WIDTH-30, 1);
    _imageview3.backgroundColor = kBackgroundColor;
}
- (void)reloadworkCell1DaiYuYue{
    _lb1.text = @"顾客姓名:";
    _lb2.text = @"所属技师:";
    _lb3.text = @"服务项目:";
    _lb4.text = @"待预约待预约待预约待预约";
    _lb5.text = @"张爱玲张爱玲张爱玲张爱玲张爱玲";
    _lb6.text = @"玉玲珑（新）1套待预约待预约";
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_imageview1.right+10, _imageview1.top, _lb1.width, _lb1.height);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb2.width, _lb2.height);
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.right+5, _lb1.top, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.right+5, _lb2.top, _lb5.width, _lb5.height);
    
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb6.width, _lb6.height);
    
    _lb7.hidden = YES;
    _imageview2.hidden = YES;
}

- (void)reloadworkCell1DaiGenJinShouQianGenJin{
    _lb1.text = @"顾客姓名:";
    _lb2.text = @"顾客电话:";
    _lb3.text = @"";
    _lb4.text = @"售前跟进售前跟进";
    _lb5.text = @"会员会员会员会员";
    _lb6.text = @"张三售前跟进售前跟进";
    _lb7.text = @"顾客生日售前跟进";
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_imageview1.right+10, _imageview1.top, _lb1.width, _lb1.height);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb2.width, _lb2.height);
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.right+5, _lb1.top, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.right+5, _lb2.top, _lb5.width, _lb5.height);
    
    _lb6.hidden = YES;
    _lb7.hidden = YES;
    _imageview2.hidden = YES;
    _btn1.hidden = YES;
}
- (void)reloadworkCell1DaiGenJinKaiFaGuanKong{
    _lb1.text = @"顾客姓名:";
    _lb2.text = @"会员等级:";
    _lb3.text = @"所属技师:";
    _lb4.text = @"开发管控开发管控开发管控";
    _lb5.text = @"会员开发管控开发管控";
    _lb6.text = @"张三张三张三开发管控开发管控";
    
    _lb7.text = @"顾客生日";
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_imageview1.right+10, _imageview1.top, _lb1.width, _lb1.height);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb2.width, _lb2.height);
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.right+5, _lb1.top, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.right+5, _lb2.top, _lb5.width, _lb5.height);
    
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb6.width, _lb6.height);
    
    [_lb7 sizeToFit];
    _imageview2.frame = CGRectMake(SCREEN_WIDTH - 15 - _lb7.width-20, 15, _lb7.width+20, _tempbiaoqian.size.height);
    _lb7.frame =_imageview2.frame;
    _lb7.center = CGPointMake(_imageview2.center.x+7, _imageview2.center.y);
    
    _btn1.hidden = YES;
}

- (void)reloadworkCell1DaiGenJinKeQingWeiHu{
    _lb1.text = @"顾客姓名:";
    _lb2.text = @"会员等级:";
    _lb3.text = @"所属技师:";
    _lb4.text = @"客情维护开发管控开发管控";
    _lb5.text = @"会员开发管控开发管控开发管";
    _lb6.text = @"张三张三张三开发管控开发管";
    
    _lb7.text = @"顾客生日";
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(_imageview1.right+10, _imageview1.top, _lb1.width, _lb1.height);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+8, _lb2.width, _lb2.height);
    
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.right+5, _lb1.top, _lb4.width, _lb4.height);
    
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.right+5, _lb2.top, _lb5.width, _lb5.height);
    
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb6.width, _lb6.height);
    
    
    [_lb7 sizeToFit];
    _imageview2.frame = CGRectMake(SCREEN_WIDTH - 15 - _lb7.width-20, 15, _lb7.width+20, _tempbiaoqian.size.height);
    _lb7.frame =_imageview2.frame;
    _lb7.center = CGPointMake(_imageview2.center.x+7, _imageview2.center.y);
    
    _btn1.hidden = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
