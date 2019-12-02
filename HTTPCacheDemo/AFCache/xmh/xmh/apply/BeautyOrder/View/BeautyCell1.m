//
//  BeautyCell1.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCell1.h"

@interface BeautyCell1()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;

@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *imageMore;
@end

@implementation BeautyCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(14);
    
    _lb3.textColor = kLabelText_Commen_Color_9;
    _lb3.font = FONT_SIZE(11);
    _lb4.textColor = kLabelText_Commen_Color_9;
    _lb4.font = FONT_BOLD_SIZE(11);
    _lb5.textColor = kLabelText_Commen_Color_9;
    _lb5.font = FONT_BOLD_SIZE(11);
    
    _lb6.textColor = kLabelText_Commen_Color_3;
    _lb6.font = FONT_SIZE(14);
    _lb7.textColor = kLabelText_Commen_Color_9;
    _lb7.font = FONT_SIZE(11);
    _lb8.textColor = kLabelText_Commen_Color_9;
    _lb8.font = FONT_SIZE(11);
    _lb9.textColor = kLabelText_Commen_Color_9;
    _lb9.font = FONT_SIZE(11);
    
    _line1.backgroundColor = kBackgroundColor;
    _line2.backgroundColor = kBackgroundColor;
    
    UIImage *im = [UIImage imageNamed:@"gengduo"];
    _imageMore.image = im;
    _imageMore.frame = CGRectMake(SCREEN_WIDTH - 15*WIDTH_SALE_BASE - im.size.width, 40+60, im.size.width, im.size.height);
}
- (void)reloadBeautyCell1YuanGong:(BeautyHomeDModel *)model{
    
        _lb1.text = model.name;
        _lb2.text = @"总负债:";
        _lb3.text = @"人均消耗项目数:";
        _lb4.text = @"耗卡单价:";
        _lb5.text = @"人均到店次数:";
    
        _lb6.text = [NSString stringWithFormat:@"%.2f元",model.liabilitiesl];
        _lb7.text = [NSString stringWithFormat:@"%.0f个",model.column1];
        _lb8.text = [NSString stringWithFormat:@"%.2f元",model.column2];
        _lb9.text = [NSString stringWithFormat:@"%.1f次",model.column3];
    

    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15*WIDTH_SALE_BASE, 15, _lb1.width, _lb1.height);
    _line1.frame = CGRectMake(0, 40, SCREEN_WIDTH, 1);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _line1.bottom+15, _lb2.width, _lb2.height);
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.left, _lb3.bottom+8, _lb4.width, _lb4.height);
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.left, _lb4.bottom+8, _lb5.width, _lb5.height);
    
    _line2.frame = CGRectMake(0, _lb5.bottom+15, SCREEN_WIDTH, 10);
        
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb6.width, _lb6.height);
    
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb7.width, _lb7.height);
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb8.width, _lb8.height);
    [_lb9 sizeToFit];
    _lb9.frame = CGRectMake(_lb5.right+5, _lb5.top, _lb9.width, _lb9.height);
}

- (void)reloadBeautyCell1_1YuanGong:(BeautyHomeUModel *)model{
    _lb1.text = model.name;
    _lb2.text = @"总负债:";
    _lb3.text = @"人均消耗项目数:";
    _lb4.text = @"耗卡单价:";
    _lb5.text = @"人均到店次数:";
    _lb6.text = @"5000元";
    _lb7.text = @"12个";
    _lb8.text = @"500元";
    _lb9.text = @"3次";
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15*WIDTH_SALE_BASE, 15, _lb1.width, _lb1.height);
    _line1.frame = CGRectMake(0, 40, SCREEN_WIDTH, 1);
    
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _line1.bottom+15, _lb2.width, _lb2.height);
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+8, _lb3.width, _lb3.height);
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb1.left, _lb3.bottom+8, _lb4.width, _lb4.height);
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb2.left, _lb4.bottom+8, _lb5.width, _lb5.height);
    
    _line2.frame = CGRectMake(0, _lb5.bottom+15, SCREEN_WIDTH, 10);
    
    [_lb6 sizeToFit];
    _lb6.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb6.width, _lb6.height);
    
    [_lb7 sizeToFit];
    _lb7.frame =CGRectMake(_lb3.right+5, _lb3.top, _lb7.width, _lb7.height);
    [_lb8 sizeToFit];
    _lb8.frame =CGRectMake(_lb4.right+5, _lb4.top, _lb8.width, _lb8.height);
    [_lb9 sizeToFit];
    _lb9.frame = CGRectMake(_lb5.right+5, _lb5.top, _lb9.width, _lb9.height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
