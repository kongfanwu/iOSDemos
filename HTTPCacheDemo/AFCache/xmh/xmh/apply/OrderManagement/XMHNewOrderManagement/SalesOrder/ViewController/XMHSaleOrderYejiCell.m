//
//  XMHSaleOrderYejiCell.m
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSaleOrderYejiCell.h"
#import "XMHComputeOrderAchievementModel.h"
#import "MLJishiSearchModel.h"
#import "UITableViewCell+ZHCreate.h"
#import "XMHComputeOrderAchievementModel.h"
@interface XMHSaleOrderYejiCell() <UITextFieldDelegate>
@property (nonatomic, strong) UIView *bgView, *yuanGongBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) XMHComputeOrderAchievementModel *model;
@property (nonatomic, strong) MLJiShiModel *jishiModel;
/** <##> */
@property (nonatomic, strong) NSArray *jishiList;
/** <##> */
@property (nonatomic, strong) UIButton *changTrueButton, *changFalseButton;
@property (nonatomic, strong) UIButton *xiaoHaoTrueButton, *xiaoHaoFalseButton;
@end
@implementation XMHSaleOrderYejiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = kColorF5F5F5;
        
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

- (void)refresCellModel:(XMHComputeOrderAchievementModel *)model {
   
    _model = model;
    [_bgView removeAllSubViews];
    
    self.titleLabel = UILabel.new;
    _titleLabel.font = FONT_SIZE(15);
    _titleLabel.textColor = kColor3;
    _titleLabel.text = @"业绩划分";
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(18);
    }];
    
    // 业绩
    UILabel *yejiTitleLabel = [self leftTitleLabel];
    yejiTitleLabel.text = @"业绩归属";
    [_bgView addSubview:yejiTitleLabel];
    [yejiTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(kMargin);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(18);
    }];
    
    UIButton *yejiButton = [self rightButton];
    [yejiButton addTarget:self action:@selector(yejiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:yejiButton];
    [yejiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(yejiTitleLabel);
        make.right.mas_equalTo(-15);
        make.left.equalTo(yejiTitleLabel.mas_right).offset(10);
        make.height.mas_equalTo(18);
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
        make.top.equalTo(yejiTitleLabel.mas_bottom).offset(kMargin);
        make.left.equalTo(yejiTitleLabel);
        make.height.mas_equalTo(18);
    }];
    
    UIButton *menDianButton = [self rightButton];
    [menDianButton addTarget:self action:@selector(menDianButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:menDianButton];
    [menDianButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(menDianTitleLabel);
        make.right.mas_equalTo(-15);
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
        make.top.equalTo(menDianTitleLabel.mas_bottom).offset(kMargin);
        make.left.equalTo(yejiTitleLabel);
        make.height.mas_equalTo(18);
    }];
    
    UIButton *dianZhangButton = [self rightButton];
    [dianZhangButton addTarget:self action:@selector(dianZhangButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:dianZhangButton];
    [dianZhangButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dianZhangTitleLabel);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(18);
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
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:UIImageName(@"service_add") forState:UIControlStateNormal];
    [_bgView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addjishuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(yuanGongLabel.mas_centerY);
    }];
    
    
    self.yuanGongBgView = [self createYuanGongViewModel:model.jiShiList];
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

- (UIView *)createYuanGongViewModel:(NSArray *)modelArr {
    UIView *view = UIView.new;
    
    self.jishiList = modelArr;
    
    UIView *lastTitleLabel;
    for (int i = 0; i < self.jishiList.count; i++) {
        MLJiShiModel *jishiModel = [self.jishiList safeObjectAtIndex:i];
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
            
            if (i == self.jishiList.count - 1) {
                make.bottom.equalTo(view).offset(-15);
            }
        }];
        // 拉伸优先级低
        [titlLabel setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        // 压缩优先级低
        [titlLabel setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
        
        lastTitleLabel = titlLabel;
       
        UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        delectBtn.tag = i + 1000;
        [delectBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
        [delectBtn addTarget:self action:@selector(delectjiShiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:delectBtn];
        [delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.centerY.equalTo(titlLabel);
            make.right.mas_equalTo(view.mas_right);
        }];
        
        UILabel *priceLabel = [self leftTitleLabel];
        priceLabel.text = @"元";
        [view addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titlLabel);
            make.right.mas_equalTo(delectBtn.mas_left).mas_offset(-kMargin);
        }];
        
        UITextField *timeTextField = [[UITextField alloc] init];
        timeTextField.layer.borderWidth = 1;
        if (jishiModel.bfb > 0) {
             timeTextField.text = [NSString stringWithFormat:@"%.2f",jishiModel.bfb];
        }
        timeTextField.layer.borderColor = kColorE.CGColor;
        timeTextField.textAlignment = NSTextAlignmentCenter;
        timeTextField.font = FONT_SIZE(14);
        timeTextField.textColor = kColor3;
     
        timeTextField.delegate = self;
        timeTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [timeTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
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
    trueButton.selected = YES;
    
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
    
    if (tag == 1) {
        self.changTrueButton = falseButton;
        self.changFalseButton = trueButton;
        
        [trueButton setTitle:@"不算" forState:UIControlStateNormal];
        [falseButton setTitle:@"算" forState:UIControlStateNormal];
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
// 添加技师
- (void)addjishuButtonClick:(UIButton *)sender
{
     if (self.shuiShuBlock) self.shuiShuBlock(4);
}
//删除技师
- (void)delectjiShiBtnClick:(UIButton *)sender{
    NSInteger tag = sender.tag - 1000;
    [self.model.jiShiList removeObjectAtIndex:tag];
    if (self.deleteJiShiBlock) self.deleteJiShiBlock(_model,self, self.indexPath);
}

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
//    else if (sender.tag == 2) {
//        if (sender == _xiaoHaoTrueButton) {
//            _xiaoHaoTrueButton.selected = YES;
//            _xiaoHaoFalseButton.selected = NO;
//            amodel.xiaohao = YES;
//        } else {
//            _xiaoHaoTrueButton.selected = NO;
//            _xiaoHaoFalseButton.selected = YES;
//            amodel.xiaohao = NO;
//        }
//    }
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //新输入的
    if (string.length == 0) {
        return YES;
    }
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //正则表达式（只支持两位小数）
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    //判断新的文本内容是否符合要求
    return [self isValid:checkStr withRegex:regex];
}

- (void)textFieldTextChange:(UITextField *)textField
{
    NSInteger tag = textField.tag - 1000;
    MLJiShiModel *jishiModel =  [self.model.jiShiList safeObjectAtIndex:tag];
    jishiModel.bfb = [textField.text floatValue];
}
//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
