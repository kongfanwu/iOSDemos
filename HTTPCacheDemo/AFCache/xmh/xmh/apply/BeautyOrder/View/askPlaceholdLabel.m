//
//  askPlaceholdLabel.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/7/3.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "askPlaceholdLabel.h"

@implementation askPlaceholdLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {-17, 2, 0, 0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end
