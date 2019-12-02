//
//  XHMCouponMultipleAlertCell.m
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XHMCouponMultipleAlertCell.h"
#import "XMHItemModel.h"

@interface XHMCouponMultipleAlertCell()
/** <##> */
@property (nonatomic, strong) UIButton *button;
@end

@implementation XHMCouponMultipleAlertCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_button setTitleColor:kColor6 forState:UIControlStateNormal];
//        [_button setTitleColor:kColorTheme forState:UIControlStateSelected];
//        _button.titleLabel.font = FONT_SIZE(14);
//        [_button cornerRadius:3];
//        _button.backgroundColor = UIColor.whiteColor;
//        _button.borderWidth = kBorderWidth;
//        [self.contentView addSubview:_button];
//        _button.userInteractionEnabled = NO;
//
//        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.contentView);
//        }];
        
        UIButton *falseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button = falseButton;
        [falseButton setTitle:@"全部门店" forState:UIControlStateNormal];
        [falseButton setTitleColor:kColor3 forState:UIControlStateNormal];
        [falseButton setTitleColor:kColorTheme forState:UIControlStateSelected];
        falseButton.titleLabel.font = FONT_SIZE(13);
        [falseButton setImage:UIImageName(@"coupon_weixuan") forState:UIControlStateNormal];
        [falseButton setImage:UIImageName(@"coupon_xuanzhong") forState:UIControlStateSelected];
        falseButton.userInteractionEnabled = NO;
        [self.contentView addSubview:falseButton];
        [falseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.left.mas_equalTo(15);
            make.top.bottom.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        falseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [falseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, falseButton.imageView.frame.size.width - 5, 0.0,0.0)];
    }
    return self;
}

- (void)configureWithModel:(XMHItemModel *)model {
    [_button setTitle:model.title forState:UIControlStateNormal];
    _button.selected = model.isSelect;
    
    if (!_edit) {
        [self.button setImage:nil forState:UIControlStateNormal];
        [self.button setImage:nil forState:UIControlStateSelected];
        [self.button setTitleEdgeInsets:UIEdgeInsetsMake(0, self.button.imageView.frame.size.width, 0.0,0.0)];
    }
}

@end
