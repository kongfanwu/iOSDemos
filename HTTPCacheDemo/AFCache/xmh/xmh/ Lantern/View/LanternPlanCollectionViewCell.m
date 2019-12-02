//
//  LanternPlanCollectionViewCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/25.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternPlanCollectionViewCell.h"

@implementation LanternPlanCollectionViewCell
- (UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc]init];
        _content.font = FONT_SIZE(15);
        _content.textAlignment = NSTextAlignmentCenter;
        _content.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    }
    return _content;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.content];
    }
    return self;
}

- (void)setTheLabeValueWithFont:(CGFloat)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius andContent:(NSString *)string withBackGroundColor:(UIColor *)groundColor
{
    _content.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    if (string) {
        _content.text = string;
    }
    if (font) {
        _content.font = FONT_SIZE(font);
    }
    if (textColor) {
        _content.textColor = textColor;
    }
    if (borderWidth) {
        self.layer.borderWidth = borderWidth;
    }
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    if (cornerRadius) {
        self.layer.cornerRadius = cornerRadius;
    }
    _content.backgroundColor = groundColor;
}
@end
