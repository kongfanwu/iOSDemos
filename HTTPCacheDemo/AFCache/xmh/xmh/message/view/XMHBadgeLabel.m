//
//  XMHBadgeLabel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBadgeLabel.h"

@implementation XMHBadgeLabel


+ (instancetype)defaultBadgeLabel
{
    // 默认为系统tabBarItem的Badge大小
    
    return [[XMHBadgeLabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:10];
    self.textAlignment = NSTextAlignmentCenter;
   
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = [UIColor colorWithRed:1.00 green:0.17 blue:0.15 alpha:1.00];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    // 根据内容调整label的宽度
    CGFloat stringWidth = [self widthForString:text font:self.font height:self.height];
    if (self.height > stringWidth + self.height*16/self.width) {
        self.width = self.height;
        return;
    }
    self.width = self.height*8/self.height/*left*/ + stringWidth + self.height*8/self.height/*right*/;
    
}

- (CGFloat)widthForString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}
- (void)setHeight:(CGFloat)height{
    [super setHeight:height];
    self.layer.cornerRadius = self.height * 0.5;
}
@end
