//
//  BeautyCardCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCardCell.h"

@implementation BeautyCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kBackgroundColor;
    _im1.frame = CGRectMake(0, 0, 110*WIDTH_SALE_BASE, 48);
    _im1.backgroundColor = [UIColor whiteColor];
    _lb1.textColor = kLabelText_Commen_Color_9;
    _lb1.font = FONT_SIZE(15);
    [self bringSubviewToFront:_lb1];
}
- (void)reFreshBeautyCardCell:(NSString *)strCard{
    _lb1.text = strCard;
    MzzLog(".............%ld",strCard.length);
//    [_lb1 sizeToFit];
//    _lb1.frame =CGRectMake(10, 15, _lb1.width, _lb1.height);
////    _lb1.center = CGPointMake(_im1.center.x, _im1.center.y);
}
- (void)resetimagebgWidth:(CGFloat)width{
    _lb1.frame =CGRectMake(8, 15, self.width-8, _lb1.height);
    _im1.frame = CGRectMake(3, 0, width*WIDTH_SALE_BASE, 48);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
