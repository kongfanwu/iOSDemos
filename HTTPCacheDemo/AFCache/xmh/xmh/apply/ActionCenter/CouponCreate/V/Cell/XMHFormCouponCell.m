//
//  XMHFormCouponCell.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormCouponCell.h"

@interface XMHFormCouponCell()
/** <##> */
@property (nonatomic, strong) UIView *bgView;
@end

@implementation XMHFormCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView = UIView.new;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.lineView.mas_bottom);
            make.right.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)configureWithModel:(XMHFormModel *)model {
    [super configureWithModel:model];
    
    CGFloat leftW = 10 + self.titleLabel.width + 15;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(self.titleLabel.width);
    }];
    
    [_bgView removeAllSubViews];
    NSArray *items = model.couponList;
    if (items.count) {
        for (int i = 0; i < items.count; i++) {
            XMHItemModel *credentiaOrderStateItemModel = items[i];
            UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [oneButton setTitle:credentiaOrderStateItemModel.title forState:UIControlStateNormal];
            [oneButton setTitleColor:kColor6 forState:UIControlStateNormal];
            [oneButton setTitleColor:kColorTheme forState:UIControlStateSelected];
            oneButton.titleLabel.font = FONT_SIZE(13);
            oneButton.layer.cornerRadius = 5;
            oneButton.layer.masksToBounds = YES;
            oneButton.layer.borderWidth = kBorderWidth;
            [oneButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_bgView addSubview:oneButton];
            oneButton.tag = i;
            
            if (credentiaOrderStateItemModel.isSelect) {
                oneButton.layer.borderColor = kBtn_Commen_Color.CGColor;
                oneButton.selected = YES;
            } else {
                oneButton.layer.borderColor = kColor6.CGColor;
                oneButton.selected = NO;
            }
        }
        // 一个按钮布局
        if (_bgView.subviews.count ==  1) {
            UIButton *oneButton = _bgView.subviews.firstObject;
            [oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(_bgView);
                make.width.mas_equalTo(70);
                make.right.mas_equalTo(-10);
                make.bottom.equalTo(_bgView);
            }];
        }
        // 多个按钮布局
        else if (_bgView.subviews.count > 1) {
            [_bgView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(27);
                make.centerY.equalTo(_bgView);
            }];
            CGFloat gap = ((SCREEN_WIDTH - leftW - 10) - (70 * items.count)) / (items.count + 1);
            [_bgView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:gap leadSpacing:gap tailSpacing:gap];
        }
    }
    
}

- (void)buttonClick:(UIButton *)sender {
    XMHFormModel *model = (XMHFormModel *)self.model;
    for (int i = 0; i < model.couponList.count; i++) {
        XMHItemModel *itemMdoel = model.couponList[i];
        if (i == sender.tag) {
            itemMdoel.isSelect = YES;
            model.value = @(itemMdoel.type).stringValue;
        } else {
            itemMdoel.isSelect = NO;
        }
    }
    
    XMHItemModel *itemMdoel = model.couponList[sender.tag];
    if (self.didSelectBlock) self.didSelectBlock(self, itemMdoel);
}

@end
