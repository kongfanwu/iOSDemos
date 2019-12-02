//
//  MzzPortraitCollectionViewCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPortraitCollectionViewCell.h"
#define BEE_FONT(a) [UIFont systemFontOfSize:a]

@implementation MzzPortraitCollectionViewCell
- (UIButton *)content
{
    if (!_content) {
        _content = [UIButton buttonWithType:UIButtonTypeCustom];
        _content.titleLabel.font = BEE_FONT(15);
        _content.frame = CGRectMake(0, 0, self.frame.size.width, 35);
    }
    return _content;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.content];
    }
    return self;
}

- (void)setTheLabeValueWithFont:(CGFloat)font borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius andContent:(NSString *)string
{
    _content.frame = CGRectMake(0, 0, self.frame.size.width, 35);
    if (string) {
        [_content setTitle:string forState:UIControlStateNormal];
    }
    if (font) {
        _content.titleLabel.font = BEE_FONT(font);
    }
    if (![string isEqualToString:@"添加"]) {
        self.layer.borderColor = kPortraitCellTitle_9072.CGColor;
        [_content setTitleColor:kPortraitCellTitle_9072 forState:UIControlStateNormal];
        _content.backgroundColor = kPortraitCellTitle_F3F0;

    }else{
        self.layer.borderColor = kLabelText_Commen_Color_6.CGColor;
        [_content setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        _content.backgroundColor = [UIColor whiteColor];
        [_content setImage:[UIImage imageNamed:@"stgkgl_zidingyi"] forState:UIControlStateNormal];
        _content.titleLabel.font = FONT_SIZE(13);
        [_content setTitleEdgeInsets:UIEdgeInsetsMake(0, - _content.titleLabel.bounds.size.width, 0, _content.titleLabel.bounds.size.width)];
        [_content setImageEdgeInsets:UIEdgeInsetsMake(0, _content.imageView.image.size.width-30, 0, -_content.imageView.image.size.width)];
        [_content addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    if (borderWidth) {
        self.layer.borderWidth = borderWidth;
    }
    if ([string isEqualToString:@"添加"]) {
        self.layer.cornerRadius = cornerRadius;
    }
}
-(void)addButtonAction{
    if (_addButtonBlock) {
        _addButtonBlock();
    }
}
@end
