//
//  XMHFormTaskButtonCell.m
//  xmh
//
//  Created by kfw on 2019/6/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskButtonsCell.h"

@interface XMHFormTaskButtonsCell()
@property (nonatomic, strong) UILabel *leftLabel;
/** <##> */
@property (nonatomic, strong) UIView *bgView;
/** <##> */
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation XMHFormTaskButtonsCell


// 在主表单中注册对应的cell以及对应的ID
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[XMHFormTaskButtonsCell class] forKey:XLFormRowDescriptorTypeXMHFormTaskButtonsCell];
}

// 这个方法是用来设置属性的 必须重写  类似于初始化的属性不变的属性进行预先配置
- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.leftLabel = UILabel.new;
    self.leftLabel.textColor = kColor3;
    self.leftLabel.font = FONT_SIZE(16);
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel sizeToFit];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(self.leftLabel);
    }];
    
    self.bgView = UIView.new;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right);
        make.right.mas_equalTo(0);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    // 拉伸优先级低
    [_bgView setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    // 压缩优先级低
    [_bgView setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
}

// 这个方法是用来进行更新的，外面给唯一的字段Value设定值就好了 通过self.rowDescriptor.value的值变化来进行更新
- (void)update
{
    [super update];
    self.leftLabel.text = self.rowDescriptor.title;
//    self.textField.text = self.rowDescriptor.value;
//    //    self.textField.placeholder = @"placeholder";
//
//    [self.textField setEnabled:!self.rowDescriptor.isDisabled];
//    self.textField.textColor = self.rowDescriptor.isDisabled ? [UIColor grayColor] : [UIColor blackColor];
    
    [self.leftLabel sizeToFit];
    [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.leftLabel);
    }];
    
    [_bgView removeAllSubViews];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    self.stackView = stackView;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillProportionally;
    stackView.alignment = UIStackViewAlignmentTrailing;
    stackView.spacing = 10;
    
    [_bgView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    // 拉伸优先级低
    [stackView setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    // 压缩优先级低
    [stackView setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    for (int i = 0; i < self.rowDescriptor.selectorOptions.count; i++) {
        XLFormOptionsObject*itemMdoel = self.rowDescriptor.selectorOptions[i];
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitleColor:kColorFF9072 forState:UIControlStateSelected];
        [btn setTitleColor:kColorC forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kColorFFF3F0 size:CGSizeMake(5, 5)] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:kColorF5F5F5 size:CGSizeMake(5, 5)] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_SIZE(13);
        [btn cornerRadius:3];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
     
        [btn setTitle:itemMdoel.displayText forState:UIControlStateNormal];
        
        if ([itemMdoel.formValue isEqualToString:((XLFormOptionsObject *)self.rowDescriptor.value).formValue]) {
            btn.selected = YES;
            btn.layer.borderWidth = kBorderWidth;
            btn.layer.borderColor = kColorFF9072.CGColor;
        } else {
            btn.selected = NO;
        }
        
        [btn sizeToFit];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(btn.width + 10, 29));
        }];
        [stackView addArrangedSubview:btn];
        
        btn.userInteractionEnabled = !self.rowDescriptor.isDisabled;
    }
}

/**
 返回行高，autolayout 布局一般用不到此方法
 */
//+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
//    return 100;
//}

/**
 能否成为第一响应者
 */
-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
    return (!self.rowDescriptor.isDisabled);
}

/**
 那个对象成为第一响应者
 */
-(BOOL)formDescriptorCellBecomeFirstResponder
{
    return [self becomeFirstResponder];
}

/**
 cell 被选中调用此方法
 */
-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
    NSLog(@"formDescriptorCellDidSelectedWithFormController");
}

/*
 自定义key
 NSLog(@"%@", [self formValues]);
 NSLog(@"%@", [self httpParameters]);
 */
//-(NSString *)formDescriptorHttpParameterName {
//    return @"formDescriptorHttpParameterName";
//}

/**
 当单元格变为firstResponder时调用，可用于更改单元格在最佳响应者时的外观。
 */
-(void)highlight
{
    [super highlight];
//    self.textLabel.textColor = self.tintColor;
}

/**
 在单元格重新签名firstResponder时调用
 */
-(void)unhighlight
{
    [super unhighlight];
    [self.formViewController updateFormRow:self.rowDescriptor];
}

#pragma mark - click

- (void)btnClick:(UIButton *)sender {
    
    [self.stackView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.borderWidth = 0;
        obj.selected = NO;
    }];
    
    sender.layer.borderWidth = kBorderWidth;
    sender.layer.borderColor = kColorFF9072.CGColor;
    sender.selected = YES;
    
    XMHItemModel *itemModel =  self.rowDescriptor.selectorOptions[sender.tag];
    self.rowDescriptor.value = itemModel;
}

@end
