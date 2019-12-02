//
//  XMHVipDiscountView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHVipDiscountView.h"
@interface XMHVipDiscountView ()
@property (nonatomic, strong) UILabel *infoLab;

@end

@implementation XMHVipDiscountView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.borderColor = kIm_Background_Color_c.CGColor;
        self.layer.borderWidth = 0.8;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        [self initUI];
    }
    return self;
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    if (_vipDiscountBlock) {
        _vipDiscountBlock();
    }
}
- (void)setDiscount:(NSString *)discount
{
    if (!discount) {
        self.infoLab.text = @" 请选择";
    }else{
        self.infoLab.text = discount;
    }
}
- (void)initUI
{
    UIImageView *imageView = [[UIImageView alloc]init];
    UIImage *image  = [UIImage imageNamed:@"qingxuanze-xiaojiantou"];
    imageView.image = image;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 4));
        make.right.mas_equalTo(self.mas_right).mas_offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.infoLab = [[UILabel alloc]init];
    self.infoLab.textColor = kLabelText_Commen_Color_9;
    self.infoLab.text = @"请选择";
    self.infoLab.textAlignment = NSTextAlignmentLeft;
    self.infoLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(5);
        make.right.mas_equalTo(imageView.mas_left).mas_offset(10);
        make.top.mas_equalTo(2);
        make.bottom.mas_offset(-2);
    }];
    [self.infoLab sizeToFit];
}
@end
