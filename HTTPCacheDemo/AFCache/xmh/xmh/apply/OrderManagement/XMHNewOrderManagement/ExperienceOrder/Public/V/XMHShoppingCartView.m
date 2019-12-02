//
//  XMHShoppingCart.m
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHShoppingCartView.h"
#import "XMHShoppingCartDetailView.h"
#import "XMHShoppingCartManager.h"

@interface XMHShoppingCartView()
/** <##> */
@property (nonatomic, strong) UIButton *submitButton, *shoppingButton;
/** <##> */
@property (nonatomic, strong) UILabel *priceLabel, *badgeLabel;
/** <##> */
@property (nonatomic, strong) XMHShoppingCartDetailView *shoppingDetailView;
/** 通知收到的商品model 集合 */
@property (nonatomic, strong) NSArray *modelArray;
@end

@implementation XMHShoppingCartView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartUpdateNotification:) name:kXMHShoppingCartUpdateNotification object:nil];
        
        self.backgroundColor = kColorE5E5E5;
        self.isEdit = YES;
        
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.submitButton = submitButton;
        [submitButton setBackgroundImage:[UIImage imageWithColor:kBtn_Commen_Color size:CGSizeMake(120, 44)] forState:UIControlStateNormal];
        [submitButton setBackgroundImage:[UIImage imageWithColor:kColor9 size:CGSizeMake(120, 44)] forState:UIControlStateSelected];
        [submitButton setTitle:@"去支付" forState:UIControlStateNormal];
        [submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        submitButton.titleLabel.font = FONT_SIZE(17);
        [self addSubview:submitButton];
        [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.width.mas_equalTo(120);
        }];
        WeakSelf
        [submitButton bk_addEventHandler:^(id sender) {
            if (weakSelf.shoppingCart && weakSelf.modelArray.count) {
                weakSelf.shoppingCart([weakSelf.modelArray copy]);
            }
            // 隐藏详情页
            if (weakSelf.shoppingDetailView) [weakSelf shoppingButtonClick:nil];
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.shoppingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shoppingButton setImage:UIImageName(@"stgkgl_gouwucheyoushangpin") forState:UIControlStateNormal];
        [_shoppingButton setImage:UIImageName(@"stgkgl_gouwuchewushangpin") forState:UIControlStateSelected];
        [self addSubview:_shoppingButton];
        [_shoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-10);
        }];
        [_shoppingButton addTarget:self action:@selector(shoppingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *badgeLabel = [[UILabel alloc] init];
        self.badgeLabel = badgeLabel;
        badgeLabel.font = FONT_SIZE(10);
        badgeLabel.textColor = UIColor.whiteColor;
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.backgroundColor = kBtn_Commen_Color;
        badgeLabel.layer.masksToBounds = YES;
        badgeLabel.layer.borderWidth = 1;
        badgeLabel.layer.borderColor = UIColor.whiteColor.CGColor;
        [_shoppingButton addSubview:badgeLabel];
        
        [self setterBadgeNumber:0];
        
        
        self.priceLabel = UILabel.new;
        _priceLabel.font = FONT_SIZE(15);
        _priceLabel.textColor = kColor3;
        [self addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shoppingButton.mas_right).offset(10);
            make.centerY.equalTo(self);
            make.right.equalTo(_submitButton.mas_left);
        }];
        _priceLabel.text = @"总计：";
        
        [self changeState];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *v in self.subviews) {
        if (!v.hidden && CGRectContainsPoint(v.frame, point)) {
            return YES;
        }
    }
    if (CGRectContainsPoint(self.bounds, point)) {
        return YES;
    }
    return NO;
}

#pragma mark - Private

- (void)changeState {
    _submitButton.selected = !_isEdit;
    _submitButton.userInteractionEnabled = _isEdit;
    
    _shoppingButton.selected = !_isEdit;
    _shoppingButton.userInteractionEnabled = _isEdit;
}

/**
 设置角标

 @param badge 数值
 */
- (void)setterBadgeNumber:(NSInteger)badge {
    if (badge <= 0) {
        _badgeLabel.hidden = YES;
    } else {
        _badgeLabel.hidden = NO;
    }
    _badgeLabel.text = @(badge).stringValue;
    [_badgeLabel sizeToFit];
    _badgeLabel.layer.cornerRadius = _badgeLabel.height / 2.f;
    _badgeLabel.top = -5;
    _badgeLabel.width = _badgeLabel.width + 10;
    _badgeLabel.right = 50;
    self.isEdit = YES;
}

#pragma mark - Setter

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    
    // 购物车无数据，灰色，不显示
    if (_isEdit && (IsEmpty(self.modelArray) || self.modelArray.count <= 0)) {
        _isEdit = NO;
    }
    
    [self changeState];
}

#pragma mark - Lazy

- (XMHShoppingCartDetailView *)shoppingDetailView {
    if (_shoppingDetailView) return _shoppingDetailView;
    
    _shoppingDetailView = XMHShoppingCartDetailView.new;
    [@"ee" integerValue];
    NSInteger type = self.enterType;
    _shoppingDetailView.cellType = type;
    [self insertSubview:_shoppingDetailView atIndex:0];
    [_shoppingDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT - self.height);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_top);
    }];
    __weak typeof(self) _self = self;
    [_shoppingDetailView setRemoveSuperViewBlock:^{
        __strong typeof(_self) self = _self;
        [self.shoppingDetailView removeFromSuperview];
        self.shoppingDetailView = nil;
    }];
    return _shoppingDetailView;
}

#pragma mark - Event

- (void)shoppingButtonClick:(UIButton *)sender {
    if (_shoppingDetailView) {
        [_shoppingDetailView removeFromSuperview];
        _shoppingDetailView = nil;
    } else {
        [self.shoppingDetailView description];
        self.shoppingDetailView.dataArray = self.modelArray;
    }
}

#pragma mark - Notification

- (void)shoppingCartUpdateNotification:(NSNotification *)not {
    NSArray *modelArray = not.userInfo[@"data"];
    NSString *allPrice = not.userInfo[@"allPrice"];
    
    self.modelArray = modelArray;
    
    _priceLabel.text = [NSString stringWithFormat:@"总计：¥%.2f", [allPrice floatValue]];
    [self setterBadgeNumber:modelArray.count];
}

- (void)setSubmitButtonTitle:(NSString *)submitButtonTitle
{
    NSString *title = submitButtonTitle;
    [self.submitButton setTitle:title forState:UIControlStateNormal];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
