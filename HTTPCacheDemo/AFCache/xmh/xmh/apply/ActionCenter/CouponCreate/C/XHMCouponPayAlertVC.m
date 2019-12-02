//
//  XHMCouponPayAlertVC.m
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XHMCouponPayAlertVC.h"
#import "NSString+Check.h"

@interface XHMCouponPayAlertVC () <UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
/** <##> */
@property (nonatomic, strong) UIButton *leftBtn, *rightBtn;
/** <##> */
@property (nonatomic, strong) UITextField *textField;
/** <##> */
@property (nonatomic, strong) UIView *inputBgView;
@end

@implementation XHMCouponPayAlertVC

- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(146, 146, 146);
    
    UIControl *bgViwe = [UIControl new];
    bgViwe.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:bgViwe];
    [bgViwe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof(self) _self = self;
    [bgViwe bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.contentView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = FONT_SIZE(17);
    [_contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(_contentView);
        make.left.mas_equalTo(5);
    }];
    [cancelBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    sureBtn.titleLabel.font = FONT_SIZE(17);
    [_contentView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(_contentView);
        make.right.mas_equalTo(-5);
    }];
    [sureBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        BOOL isAction = self.rightBtn.selected;
        CGFloat price = [self.textField.text floatValue];
        if (isAction && price <= 0) {
            [XMHProgressHUD showOnlyText:@"请输入支付金额"];
            return;
        }
        if (self.selectBlock) self.selectBlock(isAction, price);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kSeparatorColor;
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(cancelBtn.mas_bottom);
    }];
    
    self.titleLabel = [UILabel new];
    _titleLabel.text = _titleStr;
    _titleLabel.textColor = kColor3;
    _titleLabel.font = FONT_SIZE(17);
    [_contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
    }];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setTitle:@"不激活可使用" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [_leftBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    [_leftBtn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [_leftBtn setBackgroundImage:[UIImage imageWithColor:kColorTheme size:CGSizeMake(10, 10)] forState:UIControlStateSelected];
    _leftBtn.titleLabel.font = FONT_SIZE(14);
    [_leftBtn cornerRadius:3];
    _leftBtn.borderWidth = kBorderWidth;
    [_leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_leftBtn];

    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"激活可使用" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [_rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    [_rightBtn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [_rightBtn setBackgroundImage:[UIImage imageWithColor:kColorTheme size:CGSizeMake(10, 10)] forState:UIControlStateSelected];
    _rightBtn.titleLabel.font = FONT_SIZE(14);
    [_rightBtn cornerRadius:3];
    _rightBtn.borderWidth = kBorderWidth;
    [_rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_rightBtn];
    
    NSArray *buttons = @[_leftBtn, _rightBtn];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(35);
        make.height.mas_equalTo(29);
    }];
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:42 leadSpacing:47 tailSpacing:47];
    
    UIView *lineView2 = UIView.new;
    lineView2.backgroundColor = kSeparatorColor;
    [_contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(_leftBtn.mas_bottom).offset(16);
    }];
    
    UIView *inputBgView = UIView.new;
    self.inputBgView = inputBgView;
    [_contentView addSubview:inputBgView];
    [inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(33);
        make.right.mas_equalTo(-33);
        make.top.equalTo(lineView2.mas_bottom).offset(22);
        make.height.mas_equalTo(33);
    }];
    
    UILabel *firstLabel = [self createLabel];
    firstLabel.text= @"支付金额：";
    [inputBgView addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.equalTo(inputBgView);
    }];
    
    UILabel *lastLabel = [self createLabel];
    lastLabel.text= @"元";
    [inputBgView addSubview:lastLabel];
    [lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(inputBgView);
    }];
    
    
    self.textField = [[UITextField alloc] init];
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 17)];;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    _textField.layer.borderWidth = kBorderWidth;
    _textField.layer.borderColor = kColorC.CGColor;
    _textField.delegate = self;
    [inputBgView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLabel.mas_right);
        make.right.equalTo(lastLabel.mas_left).offset(-10);
        make.top.bottom.equalTo(inputBgView);
    }];
    if ([_payModel.money floatValue] > 0) {
        _textField.text = _payModel.money;
    }
    
    if ([_payModel.status integerValue] == 1) {
        [self buttonClick:_rightBtn];
    } else {
        [self buttonClick:_leftBtn];
    }
}

- (UILabel *)createLabel {
    UILabel *label = UILabel.new;
    label.font = FONT_SIZE(14);
    label.textColor = kColor6;
    return label;
}

- (void)buttonClick:(UIButton *)sender {
    if (sender == _leftBtn) {
        _leftBtn.selected = YES;
        _leftBtn.layer.borderColor = kColorTheme.CGColor;
        
        _rightBtn.selected = NO;
        _rightBtn.layer.borderColor = kColor6.CGColor;
        _inputBgView.hidden = YES;
    } else {
        _leftBtn.selected = NO;
        _leftBtn.layer.borderColor = kColor6.CGColor;
        
        _rightBtn.selected = YES;
        _rightBtn.layer.borderColor = kColorTheme.CGColor;;
        _inputBgView.hidden = NO;
    }
}

#pragma mark - Lazy

- (UIView *)contentView {
    if (_contentView) return _contentView;
    
    CGFloat contentViewHeight = self.view.height * 0.5;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - contentViewHeight, self.view.width, contentViewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = _contentView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _contentView.layer.mask = cornerRadiusLayer;
    return _contentView;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return [newString isVerifyPrice];
}

@end
