//
//  XMHCouponStoreCell.m
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponStoreCell.h"
#import "XMHCouponStoreModel.h"

@implementation XMHCouponStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *falseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleButton = falseButton;
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

- (void)configureWithModel:(XMHCouponStoreModel *)model {
    [super configureWithModel:model];
    [self.titleButton setTitle:model.name forState:UIControlStateNormal];
    self.titleButton.selected = model.isSelect;
    
    if (!_edit) {
        [self.titleButton setImage:nil forState:UIControlStateNormal];
        [self.titleButton setImage:nil forState:UIControlStateSelected];
        [self.titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, self.titleButton.imageView.frame.size.width, 0.0,0.0)];
    }
}

- (void)configureWithModel2:(XMHServiceGoodsModel *)model {
    [super configureWithModel:model];
    [self.titleButton setTitle:model.name forState:UIControlStateNormal];
    self.titleButton.selected = model.selectType;
    
    if (!_edit) {
        [self.titleButton setImage:nil forState:UIControlStateNormal];
        [self.titleButton setImage:nil forState:UIControlStateSelected];
        [self.titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, self.titleButton.imageView.frame.size.width, 0.0,0.0)];
    }
}

@end
