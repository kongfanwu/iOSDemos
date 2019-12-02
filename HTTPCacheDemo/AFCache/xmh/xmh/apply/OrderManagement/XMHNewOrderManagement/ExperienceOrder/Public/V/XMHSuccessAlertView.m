//
//  XMHSuccessAlertView.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSuccessAlertView.h"
#import "XMHCheckView.h"
#import "XMHBlockUpTableView.h"
@interface XMHSuccessAlertView()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy)NSString *message;
@property (nonatomic, copy)NSString *cancelTitle;
@property (nonatomic, copy)NSString *otherTitle;
@property (nonatomic, strong) UIView *bigVew;
@property (nonatomic, strong) UITextField *field;
/** tableView 数据源 */
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation XMHSuccessAlertView

- (instancetype)initWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitle click:(ButtonOnlick)click;
{
    if (self = [super init]) {
        _message = title;
        _cancelTitle = cancelButtonTitle;
        _otherTitle = otherButtonTitle;
        _onclick = click;
        self.backgroundColor = [kLabelText_Commen_Color_3 colorWithAlphaComponent:0.5];
        [self createSubView];
    }
    return self;
}
- (instancetype)initWithTitle:(nullable NSString *)title withTwoBtnclick:(ButtonOnlick)click
{
    if (self = [super init]) {
        _message = title;
        _onclick = click;
        self.backgroundColor = [kLabelText_Commen_Color_3 colorWithAlphaComponent:0.5];
        [self createSubView1];
    }
    return self;
}
-(instancetype)initWithTextFieldTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(TextFieldOnlick)click{
    if (self = [super init]) {
        _message = title;
        self.cancelTitle = leftButtonTitle;
        self.otherTitle = rightButtonTitle;
        _textFieldOnclick = click;
        [self setUpTextFieldUI];
    }
    return self;
}
/**
 带tableView的构造方法
 
 @param title 提示文字
 @param dataSource tableView的数据源
 @param sureButtonTitle 确认按钮文字
 @param click 点击事件
 @return 返回弹框
 */
- (instancetype)initWithTitle:(nullable NSString *)title tableViewDataSource:(nullable NSArray *)dataSource sureButtonTitle:(NSString *)sureButtonTitle click:(ButtonOnlick)click
{
    if (self = [super init]) {
        _message = title;
        _message = title;
        _onclick = click;
        _dataSource = dataSource;
        self.otherTitle = sureButtonTitle;
        [self setUpTableViewUI];
    }
    return self;
}
/**
 提示弹框
 
 @param title 提示
 @return 返回弹框
 */
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        _message = title;
//         self.backgroundColor = Color_NormalBG;
        [self creatView];
        self.bigVew.backgroundColor = [kLabelText_Commen_Color_3 colorWithAlphaComponent:0.5];
    }
    return self;
  
}
- (void)creatView{
    [self creatBgView];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(47, 0 , self.bgView.width - 2 * 47, self.bgView.height - 50)];
    lab.text = _message;
    lab.numberOfLines = 0;
    lab.textAlignment =  NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = kLabelText_Commen_Color_6;
    [self.bgView addSubview:lab];
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(0, lab.bottom, self.bgView.width, 1)];
    hLine.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:hLine];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:kLabelText_Commen_Color_ea007e forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.tag = 0;
    [self.bgView addSubview:btn];
    btn.frame = CGRectMake(0, hLine.bottom, self.bgView.width, 49);
}
- (void)createSubView1
{
    [self creatBgView];
    
 
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0,  0, self.bgView.width, self.bgView.height - 49)];
    lab.text = _message;
    lab.textAlignment =  NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = kLabelText_Commen_Color_6;
    [self.bgView addSubview:lab];
    
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(0, lab.bottom , self.bgView.width, 0.5)];
    hLine.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:hLine];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.cancelBtn.tag = 0;
    [self.bgView addSubview:self.cancelBtn];
    
    self.otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherBtn.tag = 1;
    [self.otherBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.otherBtn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateNormal];
    [self.otherBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.otherBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.bgView addSubview:self.otherBtn];
    
    
    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(self.bgView.width * 0.5 , hLine.bottom, 0.5, 49)];
    vLine.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:vLine];
    
    self.cancelBtn.frame = CGRectMake(0, hLine.bottom, self.bgView.width * 0.5, 49);
    self.otherBtn.frame = CGRectMake(self.bgView.width * 0.5 + 0.5, hLine.bottom, self.bgView.width * 0.5 - 0.5, 49);
}
- (void)createSubView
{
    [self creatBgView];
    
    XMHCheckView *view = [[XMHCheckView alloc]initWithFrame:CGRectMake((self.bgView.width - 43) * 0.5, 25, 43, 43)];
    [self.bgView addSubview:view];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, view.bottom + 15, self.bgView.width, 21)];
    lab.text = _message;
    lab.textAlignment =  NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = kLabelText_Commen_Color_6;
    [self.bgView addSubview:lab];
    
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.bgView.height - 49 - kSeparatorHeight, self.bgView.width, kSeparatorHeight)];
    hLine.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:hLine];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.cancelBtn.tag = 0;
    [self.bgView addSubview:self.cancelBtn];
    
    self.otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherBtn.tag = 1;
    [self.otherBtn setTitle:_otherTitle forState:UIControlStateNormal];
    [self.otherBtn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    [self.otherBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.otherBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.bgView addSubview:self.otherBtn];
    
    
    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(self.bgView.width * 0.5 , hLine.bottom, 0.5, 49)];
    vLine.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:vLine];
    
    self.cancelBtn.frame = CGRectMake(0, hLine.bottom, self.bgView.width * 0.5, 49);
    self.otherBtn.frame = CGRectMake(self.bgView.width * 0.5 + 0.5, hLine.bottom, self.bgView.width * 0.5 - 0.5, 49);

}
- (void)setUpTextFieldUI
{
    [self creatBgView];
    UITextField *filed = [[UITextField alloc]init];
    filed.placeholder = _message;
    filed.font = FONT_SIZE(16);
    filed.textAlignment = NSTextAlignmentCenter;
    filed.textColor = kLabelText_Commen_Color_6;
    [filed setValue:kColor9 forKeyPath:@"_placeholderLabel.textColor"];
    [filed setValue:FONT_SIZE(16) forKeyPath:@"_placeholderLabel.font"];
    filed.frame = CGRectMake(15, (self.bgView.height - 49 - 35)/2, self.bgView.width - 30, 35);
    filed.delegate = self;
    [filed setBackgroundColor:kColorF5F5F5];
    [self.bgView addSubview:filed];
    
    self.field = filed;
   
 
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.bgView.height - 49, self.bgView.width, 0.5)];
    hLine.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:hLine];
    
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.cancelBtn.tag = 0;
    [self.bgView addSubview:self.cancelBtn];
    
    self.otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherBtn.tag = 1;
    [self.otherBtn setTitle:_otherTitle forState:UIControlStateNormal];
    [self.otherBtn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateNormal];
    [self.otherBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.otherBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.bgView addSubview:self.otherBtn];
    
    
    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(self.bgView.width * 0.5 , hLine.bottom, 0.5, 49)];
    vLine.backgroundColor = kSeparatorLineColor;
    [self.bgView addSubview:vLine];
    
    self.cancelBtn.frame = CGRectMake(0, hLine.bottom, self.bgView.width * 0.5, 49);
    self.otherBtn.frame = CGRectMake(self.bgView.width * 0.5 + 0.5, hLine.bottom, self.bgView.width * 0.5 - 0.5, 49);
}

- (void)setUpTableViewUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.bigVew = [[UIView alloc]initWithFrame:self.bounds];
    self.bigVew.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self addSubview:self.bigVew];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(48, 177, SCREEN_WIDTH - 48 * 2, 334)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.center = self.center;
    [self addSubview:self.bgView];
    
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = self.bgView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.bgView.layer.mask = cornerRadiusLayer;
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.bgView.width, 72)];
    headerView.backgroundColor = UIColor.whiteColor;
    [self.bgView addSubview:headerView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 15, headerView.width - 2 * 35, 42)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_SIZE(14);
    label.textColor = kColor6;
    label.text = _message;
    [headerView addSubview:label];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.bottom , headerView.width, kSeparatorHeight)];
    line.backgroundColor = kSeparatorColor;
    [self.bgView addSubview:line];
    
    XMHBlockUpTableView *tableView = [[XMHBlockUpTableView alloc]initWithFrame:CGRectMake(0, line.bottom, self.bgView.width, 206)];
    tableView.dataArr = _dataSource;
    tableView.backgroundColor = UIColor.whiteColor;
    [self.bgView addSubview:tableView];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, tableView.bottom , headerView.width, kSeparatorHeight)];
    line1.backgroundColor = kSeparatorColor;
    [self.bgView addSubview:line1];
    
    self.otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherBtn.frame  =CGRectMake(0, line1.bottom, self.bgView.width, 45);
    self.otherBtn.tag = 1;
    [self.otherBtn setTitle:self.otherTitle forState:UIControlStateNormal];
    [self.otherBtn setTitleColor:[ColorTools colorWithHexString:@"#EA007E"] forState:UIControlStateNormal];
    [self.otherBtn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.otherBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.bgView addSubview:self.otherBtn];
    
    
}
-(void)btnOnclick:(UIButton *)btn
{
    if (self.onclick) {
        self.onclick(btn.tag);
    }
    if (self.textFieldOnclick) {
        self.textFieldOnclick(btn.tag,self.field.text);
    }
     [self dismiss];
}
- (void)dismissView
{
    [self dismiss];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //新输入的
    if (string.length == 0) {
        return YES;
    }
    if (_kucunLimit) {
        //判断新的文本内容是否符合要求
        if ([self validateNumber:string] && [textField.text floatValue] <= 999999) {
            return YES;
        }
    }
   
    return NO;
}
- (BOOL)validateNumber:(NSString *) textString
{
    // 其中^[0-9]+$表示字符串中只能包含>=1个0-9的数字。
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}
#pragma mark - 弹出此弹窗
/** 弹出此弹窗 */
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}
- (void)creatBgView
{
    self.frame = [UIScreen mainScreen].bounds;
    self.bigVew = [[UIView alloc]initWithFrame:self.bounds];
    self.bigVew.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self addSubview:self.bigVew];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(48, 177, SCREEN_WIDTH - 48 * 2, 175)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.center = self.center;
    [self addSubview:self.bgView];
    
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = self.bgView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    self.bgView.layer.mask = cornerRadiusLayer;
}
@end
