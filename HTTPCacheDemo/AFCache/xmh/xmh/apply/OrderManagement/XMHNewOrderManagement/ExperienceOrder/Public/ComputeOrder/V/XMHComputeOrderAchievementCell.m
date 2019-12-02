//
//  XMHComputeOrderAchievementCell.m
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHComputeOrderAchievementCell.h"
#import "XMHComputeOrderAchievementModel.h"
#import "MLJishiSearchModel.h"
#import "UITableViewCell+ZHCreate.h"
#import "NSString+Check.h"

@interface XMHComputeOrderAchievementCell() <UITextFieldDelegate>
@property (nonatomic, strong) UIView *bgView, *yuanGongBgView;
@property (nonatomic, strong) UILabel *titleLabel;

/** <##> */
@property (nonatomic, strong) NSArray *jishiList;
/** <##> */
@property (nonatomic, strong) UIButton *changTrueButton, *changFalseButton;
@property (nonatomic, strong) UIButton *xiaoHaoTrueButton, *xiaoHaoFalseButton;
@end

@implementation XMHComputeOrderAchievementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.bgView = UIView.new;
        _bgView.backgroundColor = UIColor.whiteColor;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configureWithModel:(XMHComputeOrderAchievementModel *)model {
    [super configureWithModel:model];
    
    [_bgView removeAllSubViews];
    
    self.titleLabel = UILabel.new;
    _titleLabel.font = FONT_SIZE(15);
    _titleLabel.textColor = kColor3;
    _titleLabel.text = @"业绩划分";
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.top.mas_equalTo(15);
    }];
    
    // 业绩
    UILabel *yejiTitleLabel = [self leftTitleLabel];
    yejiTitleLabel.text = @"业绩归属";
    [_bgView addSubview:yejiTitleLabel];
    [yejiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
    }];
    
    UIButton *yejiButton = [self rightButton];
    [yejiButton addTarget:self action:@selector(yejiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:yejiButton];
    [yejiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(yejiTitleLabel);
        make.right.mas_equalTo(-15);
//        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.left.equalTo(yejiTitleLabel.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    if (model.yeJGuiShuModel) {
        [yejiButton setImage:nil forState:UIControlStateNormal];
        [yejiButton setTitle:model.yeJGuiShuModel.showName forState:UIControlStateNormal];
        [yejiButton setTitleColor:kColor6 forState:UIControlStateNormal];
    }
    
    // 门店
    UILabel *menDianTitleLabel = [self leftTitleLabel];
    menDianTitleLabel.text = @"门店归属";
    [_bgView addSubview:menDianTitleLabel];
    [menDianTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yejiTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(yejiTitleLabel);
    }];
    
    UIButton *menDianButton = [self rightButton];
    [menDianButton addTarget:self action:@selector(menDianButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:menDianButton];
    [menDianButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(menDianTitleLabel);
        make.right.mas_equalTo(-15);
//        make.size.equalTo(yejiButton);
        make.left.height.equalTo(yejiButton);
    }];
    
    if (model.menDianModel) {
        [menDianButton setImage:nil forState:UIControlStateNormal];
        [menDianButton setTitle:model.menDianModel.store_name forState:UIControlStateNormal];
        [menDianButton setTitleColor:kColor6 forState:UIControlStateNormal];
    }
    
    // 店长
    UILabel *dianZhangTitleLabel = [self leftTitleLabel];
    dianZhangTitleLabel.text = @"店长归属";
    [_bgView addSubview:dianZhangTitleLabel];
    [dianZhangTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(menDianTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(yejiTitleLabel);
    }];
    
    UIButton *dianZhangButton = [self rightButton];
    [dianZhangButton addTarget:self action:@selector(dianZhangButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:dianZhangButton];
    [dianZhangButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dianZhangTitleLabel);
        make.right.mas_equalTo(-15);
//        make.size.equalTo(yejiButton);
        make.left.height.equalTo(yejiButton);
    }];
 
    if (model.dianZhangModel) {
        [dianZhangButton setImage:nil forState:UIControlStateNormal];
        [dianZhangButton setTitle:model.dianZhangModel.name forState:UIControlStateNormal];
        [dianZhangButton setTitleColor:kColor6 forState:UIControlStateNormal];
    }
    
    // 员工
    UILabel *yuanGongLabel = [self leftTitleLabel];
    yuanGongLabel.text = @"员工归属";
    [_bgView addSubview:yuanGongLabel];
    [yuanGongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dianZhangTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(yejiTitleLabel);
    }];
 
    self.yuanGongBgView = [self createYuanGongViewModel:model];
    [_bgView addSubview:_yuanGongBgView];
    [_yuanGongBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yuanGongLabel.mas_bottom).offset(10);
        make.left.equalTo(yuanGongLabel);
        make.right.mas_equalTo(-15);
    }];
    
    // 厂家业绩
    UILabel *changLabel = [self leftTitleLabel];
    changLabel.text = @"厂家业绩";
    [_bgView addSubview:changLabel];
    [changLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yuanGongBgView.mas_bottom).offset(10);
        make.left.equalTo(yejiTitleLabel);
    }];
    
    [self createSelectViewSuperViwe:_bgView changLabel:changLabel tag:1];
    
    // 是否算消耗
    UILabel *xiaoHaoLabel = [self leftTitleLabel];
    xiaoHaoLabel.text = @"是否算消耗";
    [_bgView addSubview:xiaoHaoLabel];
    [xiaoHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changLabel.mas_bottom).offset(10);
        make.left.equalTo(yejiTitleLabel);
    }];
    
    [self createSelectViewSuperViwe:_bgView changLabel:xiaoHaoLabel tag:2];
    
    // 提示
    UILabel *tiShiLabel = UILabel.new;
    tiShiLabel.font = FONT_SIZE(11);
    tiShiLabel.textColor = kColor9;
    tiShiLabel.text = @"（备注：此业绩选择是算消耗业绩，选择否不算消耗业绩）";
    [_bgView addSubview:tiShiLabel];
    [tiShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xiaoHaoLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-15);
    }];
}

- (UILabel *)leftTitleLabel {
    UILabel *titleLabel = UILabel.new;
    titleLabel.font = FONT_SIZE(14);
    titleLabel.textColor = kColor3;
    return titleLabel;
}

- (UIButton *)rightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"请选择  " forState:UIControlStateNormal];
    [button setTitleColor:kColorC forState:UIControlStateNormal];
    [button setImage:UIImageName(@"xiala") forState:UIControlStateNormal];
    button.titleLabel.font = FONT_SIZE(14);
    button.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft; // 左右翻转
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; // 内容靠右
    button.titleLabel.textAlignment = NSTextAlignmentLeft; // 靠左，以显示label后边的空格间距
    return button;
}

- (UIView *)createYuanGongViewModel:(XMHComputeOrderAchievementModel *)model {
    UIView *view = UIView.new;
    
    NSArray *jishiList = [model jiShiList];
    self.jishiList = jishiList;
    
    UIView *lastTitleLabel;
    for (int i = 0; i < jishiList.count; i++) {
        MLJiShiModel *jishiModel = jishiList[i];
        
        UILabel *titlLabel = [self leftTitleLabel];
        titlLabel.text = jishiModel.name;
        [view addSubview:titlLabel];
        [titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(30);
            if (lastTitleLabel) {
                make.top.equalTo(lastTitleLabel.mas_bottom).offset(10);
            } else {
                make.top.mas_equalTo(0);
            }
            
            if (i == jishiList.count - 1) {
                make.bottom.equalTo(view).offset(-15);
            }
        }];
        // 拉伸优先级低
        [titlLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
        [titlLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        lastTitleLabel = titlLabel;
        
        UILabel *priceLabel = [self leftTitleLabel];
        priceLabel.text = @"元";
        [view addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titlLabel);
            make.right.mas_equalTo(0);
        }];
        
        UITextField *timeTextField = [[UITextField alloc] init];
        timeTextField.delegate = self;
        timeTextField.text = jishiModel.inputPrice;
        timeTextField.layer.borderWidth = 0.5;
        timeTextField.layer.borderColor = kColorE.CGColor;
        timeTextField.textAlignment = NSTextAlignmentCenter;
        timeTextField.font = FONT_SIZE(14);
        timeTextField.textColor = kColor3;
        timeTextField.keyboardType = UIKeyboardTypeDecimalPad;
        timeTextField.delegate = self;
        timeTextField.tag = 1000 + i;
        [view addSubview:timeTextField];
        [timeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 30));
            make.centerY.equalTo(titlLabel);
            make.right.equalTo(priceLabel.mas_left).offset(-5);
            make.left.equalTo(titlLabel.mas_right).offset(5);
        }];
        
    }
    
    return view;
}

- (void)createSelectViewSuperViwe:(UIView *)superView changLabel:(UIView *)changLabel tag:(NSInteger)tag {
    UIButton *trueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [trueButton setTitle:@"是" forState:UIControlStateNormal];
    [trueButton setTitleColor:kColor9 forState:UIControlStateNormal];
    trueButton.titleLabel.font = FONT_SIZE(12);
    [trueButton setImage:UIImageName(@"service_normal") forState:UIControlStateNormal];
    [trueButton setImage:UIImageName(@"service_select") forState:UIControlStateSelected];
    [trueButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    trueButton.tag = tag;
    [superView addSubview:trueButton];
    [trueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 25));
        make.left.mas_equalTo(130);
        make.centerY.equalTo(changLabel);
    }];
    trueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [trueButton setTitleEdgeInsets:UIEdgeInsetsMake(0, trueButton.imageView.frame.size.width-10, 0.0,0.0)];
    
    UIButton *falseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [falseButton setTitle:@"否" forState:UIControlStateNormal];
    [falseButton setTitleColor:kColor9 forState:UIControlStateNormal];
    falseButton.titleLabel.font = FONT_SIZE(12);
    [falseButton setImage:UIImageName(@"service_normal") forState:UIControlStateNormal];
    [falseButton setImage:UIImageName(@"service_select") forState:UIControlStateSelected];
    falseButton.tag = tag;
    [falseButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:falseButton];
    [falseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 25));
        make.left.equalTo(trueButton.mas_right).offset(44);
        make.centerY.equalTo(changLabel);
    }];
    falseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [falseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, falseButton.imageView.frame.size.width - 5, 0.0,0.0)];
    
    XMHComputeOrderAchievementModel *amodel = self.model;
    
    if (tag == 1) {
        self.changTrueButton = falseButton;
        self.changFalseButton = trueButton;
        
        [trueButton setTitle:@"不算" forState:UIControlStateNormal];
        [falseButton setTitle:@"算" forState:UIControlStateNormal];
        
        if (amodel.changJiaYeji == YES) {
            trueButton.selected = NO;
            falseButton.selected = YES;
        } else {
            trueButton.selected = YES;
            falseButton.selected = NO;
        }
    } else if (tag == 2) {
        self.xiaoHaoTrueButton = trueButton;
        self.xiaoHaoFalseButton = falseButton;
        [trueButton setTitle:@"是" forState:UIControlStateNormal];
        [falseButton setTitle:@"否" forState:UIControlStateNormal];
        if (amodel.xiaohao == YES) {
            trueButton.selected = YES;
            falseButton.selected = NO;
        } else {
            trueButton.selected = NO;
            falseButton.selected = YES;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger tag = textField.tag - 1000;
    MLJiShiModel *jishiModel = _jishiList[tag];
    jishiModel.inputPrice = textField.text;
}

#pragma mark - Event

// 厂家业绩 是否算消耗单选
- (void)selectEvent:(UIButton *)sender {
    XMHComputeOrderAchievementModel *amodel = self.model;
    
    if (sender.tag == 1) {
        if (sender == _changTrueButton) {
            _changTrueButton.selected = YES;
            _changFalseButton.selected = NO;
            amodel.changJiaYeji = YES;
        } else {
            _changTrueButton.selected = NO;
            _changFalseButton.selected = YES;
            amodel.changJiaYeji = NO;
        }
    }
    else if (sender.tag == 2) {
        if (sender == _xiaoHaoTrueButton) {
            _xiaoHaoTrueButton.selected = YES;
            _xiaoHaoFalseButton.selected = NO;
            amodel.xiaohao = YES;
        } else {
            _xiaoHaoTrueButton.selected = NO;
            _xiaoHaoFalseButton.selected = YES;
            amodel.xiaohao = NO;
        }
    }
}

// 业绩
- (void)yejiButtonClick:(UIButton *)sender {
    if (self.shuiShuBlock) self.shuiShuBlock(1);
}

// 门店
- (void)menDianButtonClick:(UIButton *)sender {
    if (self.shuiShuBlock) self.shuiShuBlock(2);
}

// 店长
- (void)dianZhangButtonClick:(UIButton *)sender {
    if (self.shuiShuBlock) self.shuiShuBlock(3);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return [newString isVerifyPrice];
}

@end
