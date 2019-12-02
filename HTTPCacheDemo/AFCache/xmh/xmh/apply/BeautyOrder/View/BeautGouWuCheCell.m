//
//  BeautGouWuCheCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautGouWuCheCell.h"

@implementation BeautGouWuCheCell{
    UIImage *imagebtn1;
    UIImage *imagebtn2;
    BeautyProjectModel *_model;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(15);
    
    imagebtn1 = [UIImage imageNamed:@"beautyjianhao"];
    imagebtn2 = [UIImage imageNamed:@"beautyjiahao"];
    
    [_btn1 setImage:imagebtn1 forState:UIControlStateNormal];
    [_btn1 setImage:imagebtn1 forState:UIControlStateHighlighted];
    [_btn2 setImage:imagebtn2 forState:UIControlStateNormal];
    [_btn2 setImage:imagebtn2 forState:UIControlStateHighlighted];
}
- (void)reFreshBeautGouWuCheCell:(BeautyProjectModel *)model{
    _model = model;
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"%@",@(model.num)];
    
    _btn2.frame = CGRectMake(SCREEN_WIDTH - 15 - imagebtn2.size.width, (69-imagebtn2.size.height)/2.0, imagebtn2.size.width, imagebtn2.size.height);
    [_lb2 sizeToFit];
    
    _lb2.frame =CGRectMake(_btn2.left -13-_lb2.width, 0, _lb2.width, _lb2.height);
    _lb2.center = CGPointMake(_lb2.center.x, _btn2.center.y);
    
    _btn1.frame = CGRectMake(_lb2.left -13-imagebtn1.size.width, 0, imagebtn1.size.width, imagebtn1.size.height);
    _btn1.center = CGPointMake(_btn1.center.x, _btn2.center.y);
    
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15, 18,_btn1.left-15-15, _lb1.height);
    _lb1.center = CGPointMake(_lb1.center.x, _btn2.center.y);
    
    _line.frame = CGRectMake(0, 68, SCREEN_WIDTH, 1);
}


- (IBAction)btn2Event:(UIButton *)sender {
    
    if (_BeautGouWuCheCellAddBlock) {
        _BeautGouWuCheCellAddBlock(_model);
    }
}

- (IBAction)btn1Event:(UIButton *)sender {
    
    if (_BeautGouWuCheCellReduceBlock) {
        _BeautGouWuCheCellReduceBlock(_model);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
