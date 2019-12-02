//
//  XMHCouponView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponView.h"

@interface XMHCouponView()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *tickLab;
@property (nonatomic, strong) UIImageView *imageView;//红包控件

@end

@implementation XMHCouponView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)setContent:(NSString *)content
{
    _content = content;
    if (_content) {
       self.tickLab.text = [NSString stringWithFormat:@"%@",content];
    }else{
        self.tickLab.text = @"请选择";
    }
    self.bgView.image = nil;
    self.imageView.hidden = YES;
}
- (void)setCoupon:(NSString *)coupon hiddenBgView:(BOOL)hiddenBgView
{
    _coupon = coupon;
    if (hiddenBgView) {
        self.bgView.image = nil;
        self.imageView.hidden = YES;
        self.tickLab.textColor = kLabelText_Commen_Color_9;
    }else{
        self.bgView.image = [UIImage imageNamed:@"ddgl_youhuiquan"];
        self.imageView.hidden = NO;
        self.tickLab.textColor = [UIColor whiteColor];
    }
    self.tickLab.text = [NSString stringWithFormat:@"%@",_coupon?_coupon:@""];
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    //点击优惠券
    if (_didCouponTickt) {
        _didCouponTickt();
    }
    
}
- (void)initUI
{
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouye-xiaojiantou"]];
    [self addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(4, 8));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    self.bgView = [[UIImageView alloc]init];
    self.bgView.image = [UIImage imageNamed:@"ddgl_youhuiquan"];
    [self addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 19));
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(arrow.mas_left).mas_offset(-10);
    }];

    self.tickLab = [[UILabel alloc]init];
    self.tickLab.font = [UIFont systemFontOfSize:10];
    self.tickLab.textColor = [UIColor whiteColor];
    self.tickLab.text = @"";
    [self.tickLab sizeToFit];
    [self.bgView addSubview:self.tickLab];
    [self.tickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.top.mas_equalTo(self.bgView);
    }];
    
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hongbao"]];
    [self.bgView addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tickLab.mas_left).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
}
@end
