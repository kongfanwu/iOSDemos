//
//  BeautyDesignDownView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyDesignDownView.h"

@implementation BeautyDesignDownView{
    UIImage *image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    _im2.backgroundColor = kColorE5E5E5;
    _im2.frame = CGRectMake(0, 70-49, SCREEN_WIDTH - 120*WIDTH_SALE_BASE, 49);
    _im2.userInteractionEnabled = YES;
    image = [UIImage imageNamed:@"stgkgl_gouwucheyoushangpin"];
    [_btn2 setImage:image forState:UIControlStateNormal];
    [_btn2 setImage:image forState:UIControlStateHighlighted];
    _btn2.frame = CGRectMake(10, 10, image.size.width, image.size.height);
    
    _lb1.text = @"20";
    _lb1.backgroundColor = kColorTheme;
    _lb1.font = FONT_SIZE(12);
    [_lb1 sizeToFit];
    _lb1.textColor = [UIColor whiteColor];
    _lb1.layer.borderColor = [UIColor whiteColor].CGColor;
    _lb1.layer.borderWidth = 1;
    _lb1.layer.cornerRadius = 7;
    _lb1.textAlignment = NSTextAlignmentCenter;
    _lb1.layer.masksToBounds = YES;
    _lb1.frame = CGRectMake(_btn2.center.x+5,5, 20, 15);
    
    _lb2.textColor = kColor3;
    _lb2.font = FONT_MEDIUM_SIZE(15);
    _lb2.text = @"规划总项目数:";
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_btn2.right+14,0, _lb2.width, _lb2.height);
    _lb2.center = CGPointMake(_lb2.center.x, _im2.center.y);
    
    _lb3.textColor = kColor3;
    _lb3.font = FONT_MEDIUM_SIZE(15);
    
    [_btn1 setTitle:@"下一步" forState:UIControlStateNormal];
    [_btn1 setTitle:@"下一步" forState:UIControlStateSelected];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _btn1.backgroundColor = kBtn_Commen_Color;
    _btn1.titleLabel.font = FONT_SIZE(17);
    
    _btn1.frame = CGRectMake(SCREEN_WIDTH - 120*WIDTH_SALE_BASE ,_im2.top,120*WIDTH_SALE_BASE, 49);
}
- (void)reFreshBeautyDesignDownView:(NSInteger)num{
    _lb1.text = [NSString stringWithFormat:@"%@",@(num)];
    _lb3.text = [NSString stringWithFormat:@"%@个",@(num)];
    [_lb3 sizeToFit];
    _lb3.frame =CGRectMake(_lb2.right+5,0, _lb3.width, _lb3.height);
    _lb3.center = CGPointMake(_lb3.center.x, _im2.center.y);
}
- (void)reFreshBeautyDesignDownViewWithCustomerBill{
    _lb1.text = @"1";
    _lb2.text = @"";
    [_btn1 setTitle:@"提交" forState:UIControlStateNormal];
    [_btn1 setTitle:@"提交" forState:UIControlStateSelected];
}
@end
