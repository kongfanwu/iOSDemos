//
//  BeautySubCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautySubCell.h"
#import "BeautyDesignMethod.h"
#import "NSString+Costom.h"
@implementation BeautySubCell{
    UIImage *image;
    UIImage *imagebtn1;
    UIImage *imagebtn2;
    CGFloat cellWidth;
    LiaoChengXiangMuModel*_model;
    BeautyCardRange*_range;
    BOOL isLiaocheng;
}

- (void)awakeFromNib {
    [super awakeFromNib];
     cellWidth = (SCREEN_WIDTH - 130*WIDTH_SALE_BASE);
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_9;
    _lb2.font = FONT_SIZE(13);
    _lb3.textColor = kLabelText_Commen_Color_9;
    _lb3.font = FONT_SIZE(13);
    _lb4.textColor = kLabelText_Commen_Color_9;
    _lb4.font = FONT_SIZE(13);
    _lb5.textColor = kLabelText_Commen_Color_9;
    _lb5.font = FONT_SIZE(13);
    _lb6.textColor = [ColorTools colorWithHexString:@"#f3b337"];
    _lb6.font = FONT_SIZE(10);
    _lb7.textColor = kLabelText_Commen_Color_3;
    _lb7.font = FONT_SIZE(17);
    
    _lb10.font = FONT_SIZE(10);
    _lb10.textColor = [ColorTools colorWithHexString:@"#F5BB4F"];
    _lb10.layer.borderWidth = kSeparatorHeight;
    _lb10.layer.borderColor = [ColorTools colorWithHexString:@"#F5BB4F"].CGColor;
    _lb10.textAlignment = NSTextAlignmentCenter;
    _lb10.layer.cornerRadius = 2;
    
    image = [UIImage imageNamed:@"beautytika"];
    imagebtn1 = [UIImage imageNamed:@"beautyjianhao"];
    imagebtn2 = [UIImage imageNamed:@"beautyjiahao"];
    
    [_btn1 setImage:imagebtn1 forState:UIControlStateNormal];
    [_btn1 setImage:imagebtn1 forState:UIControlStateHighlighted];
    [_btn2 setImage:imagebtn2 forState:UIControlStateNormal];
    [_btn2 setImage:imagebtn2 forState:UIControlStateHighlighted];
    
    _line1.backgroundColor = kColorE5E5E5;
}
- (void)reFreshBeautySubCell:(LiaoChengXiangMuModel*)model{
    isLiaocheng = YES;
    _model = model;
    LiaoChengXiangMuInfo *info = model.info;
    _lb1.text = info.name?info.name:@"";
    _lb2.text = @"剩余:";
    _lb3.text = @"时长:";
    _lb7.text = @"99";
    [_lb7 sizeToFit];
    _lb4.text = [NSString stringWithFormat:@"%ld次",(model.num)];
    _lb5.text = [NSString stringWithFormat:@"%ld分钟",info.shichang?info.shichang:0];
//    _lb6.text = [BeautyDesignMethod returnNameWithly_type:model.ly_type];
    _lb6.text = model.ly_type;
    _lb7.text = [NSString stringWithFormat:@"%ld",model.numDisplay];
    
    _lb10.text = model.ly_type;
    
    [self resetFrame];
}
- (void)reFreshBeautySubCell1:(BeautyCardRange *)model{
    isLiaocheng = NO;
    _range = model;
    _lb1.text = model.name?model.name:@"";
    _lb2.text = @"单价:";
    _lb3.text = @"时长:";
    _lb7.text = @"99";
    [_lb7 sizeToFit];
    _lb4.text = [NSString stringWithFormat:@"¥%.2f",model.price];
    _lb5.text = [NSString stringWithFormat:@"%ld分钟",model.shichang];
    _lb6.text =[NSString stringWithFormat:@"提卡-%@",model.typeName];
    _lb7.text = [NSString stringWithFormat:@"%ld",model.numDisplay];
    
    _lb10.text = [NSString stringWithFormat:@"提卡-%@",model.typeName];
    [self resetFrame];
}

- (void)resetFrame{
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(13, 20, _lb1.width, _lb1.height);
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.left, _lb1.bottom+4, _lb2.width, _lb2.height);
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb1.left, _lb2.bottom+4, _lb3.width, _lb3.height);
    
    [_lb4 sizeToFit];
    _lb4.frame =CGRectMake(_lb2.right+5, _lb2.top, _lb4.width, _lb4.height);
    [_lb5 sizeToFit];
    _lb5.frame = CGRectMake(_lb3.right+5, _lb3.top, _lb5.width, _lb5.height);
    
    [_lb6 sizeToFit];
    _im1.frame = CGRectMake(_lb1.left, _lb3.bottom+10, _lb6.width+17, _lb6.height+6);
    _im1.image = image;
    _lb6.frame =CGRectMake(_im1.left+6, _im1.top + (_im1.height - _lb6.height)/2.0, _lb6.width, _lb6.height);
    _im1.hidden = YES;
    _lb6.hidden = YES;
    [_lb10 sizeToFit];
    _lb10.frame = CGRectMake(_lb1.left, _lb3.bottom+8, _lb10.width+10, _lb10.height+6);
    
    _btn2.frame = CGRectMake(cellWidth - 10*WIDTH_SALE_BASE - imagebtn2.size.width, 0, imagebtn2.size.width, imagebtn2.size.height);
    _btn2.center = CGPointMake(_btn2.center.x, _lb2.bottom+5);
    
    _lb7.frame =CGRectMake(_btn2.left -_lb7.width-5, 0, _lb7.width, _lb7.height);
    _lb7.center = CGPointMake(_lb7.center.x, _btn2.center.y);
    
    _btn1.frame = CGRectMake(_lb7.left -imagebtn1.size.width-5, 0, imagebtn1.size.width, imagebtn1.size.height);
    _btn1.center = CGPointMake(_btn1.center.x, _btn2.center.y);
    
    _line1.frame = CGRectMake(13, _im1.bottom+15, cellWidth-13, 0.6);
}
- (IBAction)btn1Event:(UIButton *)sender {
    if (isLiaocheng) {
        if (_BeautySubCellReduceBlock) {
            _BeautySubCellReduceBlock(_model);
        }
    } else {
        if (_BeautySubCellCardReduceBlock) {
            _BeautySubCellCardReduceBlock(_range);
        }
    }
}
- (IBAction)btn2Event:(UIButton *)sender {
    if (isLiaocheng) {
        if (_BeautySubCellAddBlock) {
            _BeautySubCellAddBlock(_model);
        }
    } else {
        if (_BeautySubCellCardAddBlock) {
            _BeautySubCellCardAddBlock(_range);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
