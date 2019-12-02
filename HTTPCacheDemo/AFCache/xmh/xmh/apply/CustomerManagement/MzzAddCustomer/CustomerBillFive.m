//
//  CustomerBillFive.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerBillFive.h"

@implementation CustomerBillFive{
    UIImage *imNormal;
    UIImage *imSelect;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    imNormal = [UIImage imageNamed:@"stzhangdanquerendanxuan"];
    imSelect = [UIImage imageNamed:@"stzhangdanqueren"];
    
    [_btn1 setImage:imNormal forState:UIControlStateNormal];
    [_btn1 setImage:imSelect forState:UIControlStateSelected];
    [_btn1 addTarget:self action:@selector(btn1Event:) forControlEvents:UIControlEventTouchUpInside];
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(15);
    
}
- (void)reFreshCustomerBillFivewithTitle:(NSString *)title withSubTitle:(NSString *)subTitle withSelect:(BOOL )select{
    _lb1.text = title;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(10, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    _btn1.frame = CGRectMake(_lb1.right+20, (44-imNormal.size.height)/2.0, imNormal.size.width, imNormal.size.height);
    _lb2.text = subTitle;
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_btn1.right+15, (44-_lb2.height)/2.0, _lb2.width, _lb2.height);
}

- (void)btn1Event:(UIButton *)sender{
    sender.selected = !sender.selected;
}

@end
