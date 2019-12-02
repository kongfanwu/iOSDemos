//
//  MzzHud.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzHud.h"
#import "AppDelegate.h"
@interface MzzHud()

/** 弹窗标题 */
@property (nonatomic,copy)   NSString *title;
/** 弹窗message */
@property (nonatomic,copy)   NSString *message;
/** message label */
@property (nonatomic,strong) UILabel  *messageLabel;
/** 左边按钮title */
@property (nonatomic,copy)   NSString *leftButtonTitle;
/** 右边按钮title */
@property (nonatomic,copy)   NSString *rightButtonTitle;
/** 中间按钮title */
@property (nonatomic,copy)   NSString *centerButtonTitle;
/** 中间textField */
@property (nonatomic,weak)   UITextView *textFieldView;
/** 中间icon */
@property (nonatomic,copy)   NSString *iconStr;
/**隐藏叉号 */
@property (nonatomic,assign) BOOL hiddenCancelBtn;
@end

@implementation MzzHud


-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message centerButtonTitle:(NSString *)centerButtonTitle click:(ButtonOnlick)click{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.centerButtonTitle = centerButtonTitle;
        _onclick = click;
        [self setupOnBtnUI];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(ButtonOnlick)click{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        _onclick = click;
         [self setUpUI];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(ButtonOnlick)click hiddenCancelBtn:(BOOL)hidden
{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        _onclick = click;
        _hiddenCancelBtn = hidden;
        [self setUpUI];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle iconStr:(NSString *)iconStr click:(ButtonOnlick)click
{
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        self.iconStr = iconStr;
        _onclick = click;
        [self setIconUI];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  centerButtonTitle:(NSString *)centerButtonTitle iconStr:(NSString *)iconStr click:(ButtonOnlick)click{
    
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.centerButtonTitle = centerButtonTitle;
        self.iconStr = iconStr;
        _onclick = click;
        [self setOneButtonIconUI];
    }
    return self;
}
-(instancetype)initWithTextFieldTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle click:(TextFieldOnlick)click{
    if (self = [super init]) {
        self.title = title;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
        _textFieldOnclick = click;
        [self setUpTextFieldUI];
    }
    return self;
}
/**
 弹窗的构造方法
 @return 一个弹窗
 */

- (instancetype)initWithAwardClick:(AwardOnclick)click{
    if (self = [super init]) {
        _awardOnclick = click;
        [self setUpAwardUI];
    }
    return self;
}

- (void)setIconUI
{
    self.frame= [UIScreen mainScreen].bounds;
    WeakSelf
    self.contentTipView = [[BookRemindView alloc]initWithFrame:self.bounds leftBtnTitle:_leftButtonTitle rightBtnTitle:_rightButtonTitle content:nil];
    UIImageView * imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imv.image = [UIImage imageNamed:_iconStr];
    self.contentTipView.center = self.center;
    imv.center = CGPointMake(_contentTipView.centerX, _contentTipView.centerY -120);
    self.contentTipView.lbTitle.text = _message;
    [self.contentTipView refreshTitleFrame];
    [self.contentTipView addSubview:imv];
    [self addSubview:self.contentTipView];
    self.contentTipView.cencelBtn = ^{
        [weakSelf removeFromSuperview];
    };
    [self.contentTipView.btnLeft addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentTipView.btnRight addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setOneButtonIconUI
{
    WeakSelf;
    self.frame= [UIScreen mainScreen].bounds;
    //------- 弹窗主内容 -------//
    self.contentTipView = [[BookRemindView alloc]initWithFrame:self.bounds oneBtnTitle:_centerButtonTitle content:_message];
    self.contentTipView.lbTitle.hidden = YES;
    self.contentTipView.cencelBtn = ^{
        [weakSelf removeFromSuperview];
    };
    self.contentTipView.center = self.center;
    [self.contentTipView.btnCenter setTitle:_centerButtonTitle forState:UIControlStateNormal];
    [self addSubview:self.contentTipView];
    self.contentTipView.layer.cornerRadius = 6;
    [self.contentTipView.btnCenter addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imv.image = [UIImage imageNamed:_iconStr];
    self.contentTipView.center = self.center;
    imv.center = CGPointMake(_contentTipView.centerX, _contentTipView.centerY -170);
    [self.contentTipView refreshTitleFrame];
    [self.contentTipView addSubview:imv];
    
}
- (void)setUpAwardUI{
    
    self.frame= [UIScreen mainScreen].bounds;
    
    UIView *cover  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = .7;
    [self addSubview:cover];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick:)];
    [cover addGestureRecognizer:tap];
    
    MzzTipAwardView *tipAwardView = [[NSBundle mainBundle]loadNibNamed:@"MzzTipAwardView" owner:nil options:nil].firstObject;
    _tipAwardView = tipAwardView;
    tipAwardView.frame = CGRectMake(SCREEN_WIDTH /2 - 150, SCREEN_HEIGHT /2 - 250, 300, 300);
    [self addSubview:tipAwardView];
    
    [tipAwardView.quxiao addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    [tipAwardView.tianjia addTarget:self action:@selector(tianjia:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)coverClick:(UIGestureRecognizer *)tap{
    [self removeFromSuperview];
}

- (void)quxiao:(UIButton *)sender{
    [self removeFromSuperview];
}

- (void)tianjia:(UIButton *)sender{
    [self removeFromSuperview];
}
- (void)setUpUI{
    WeakSelf;
    self.frame = [UIScreen mainScreen].bounds;
    
    
    //------- 弹窗主内容 -------//
    self.contentTipView = [[BookRemindView alloc]initWithFrame:self.bounds leftBtnTitle:_leftButtonTitle rightBtnTitle:_rightButtonTitle content:_message];
    self.contentTipView.cencelBtn = ^{
        [weakSelf removeFromSuperview];
    };
    if (_hiddenCancelBtn) {
         self.contentTipView.btnCancel.hidden = _hiddenCancelBtn;
    }
    self.contentTipView.lbTitle.text = _title;
    self.contentTipView.center = self.center;
    [self addSubview:self.contentTipView];
    self.contentTipView.layer.cornerRadius = 6;
    [self.contentTipView.btnLeft addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentTipView.btnRight addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self contentLabelCenter];
}
- (void)setUpTextFieldUI{
    WeakSelf;
    self.frame = [UIScreen mainScreen].bounds;
    //------- 弹窗主内容 -------//
    self.contentTipView = [[BookRemindView alloc]initWithFrame:self.bounds leftBtnTitle:_leftButtonTitle rightBtnTitle:_rightButtonTitle content:nil];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    textView.layer.borderColor = [ColorTools colorWithHexString:@"999999"].CGColor;
    textView.layer.borderWidth = 1;
    _textFieldView = textView;
    [self.contentTipView addSubview:textView];
    self.contentTipView.cencelBtn = ^{
        [weakSelf removeFromSuperview];
    };
    self.contentTipView.lbTitle.text = _title;
    self.contentTipView.center = self.center;
    textView.center = CGPointMake(_contentTipView.centerX, _contentTipView.centerY -100);
    [self addSubview:self.contentTipView];
    self.contentTipView.layer.cornerRadius = 6;
    [self.contentTipView.btnLeft addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentTipView.btnRight addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupOnBtnUI{
     WeakSelf;
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    
    //------- 弹窗主内容 -------//
    self.contentTipView = [[BookRemindView alloc]initWithFrame:self.bounds oneBtnTitle:_centerButtonTitle content:_message];
    self.contentTipView.cencelBtn = ^{
        [weakSelf removeFromSuperview];
    };
    self.contentTipView.lbTitle.text = _title;
    self.contentTipView.center = self.center;
    [self.contentTipView.btnCenter setTitle:_centerButtonTitle forState:UIControlStateNormal];
    [self addSubview:self.contentTipView];
    self.contentTipView.layer.cornerRadius = 6;
    [self.contentTipView.btnCenter addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self contentLabelCenter];
}

- (void)btnOnclick:(UIButton *)btn{
    if (self.onclick) {
        self.onclick(btn.tag);
    }
    if (self.textFieldOnclick) {
        self.textFieldOnclick(btn.tag,_textFieldView.text);
    }
    [self dismiss];
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

- (void)toastWithTitle:(NSString *)title message:(NSString *)message{
    WeakSelf;
    self.title = title;
    self.message = message;
    self.frame = [UIScreen mainScreen].bounds;
    //------- 弹窗主内容 -------//
    self.contentTipView = [[BookRemindView alloc]initWithFrame:self.bounds leftBtnTitle:_leftButtonTitle rightBtnTitle:_rightButtonTitle content:_message];
    self.contentTipView.cencelBtn = ^{
        [weakSelf removeFromSuperview];
    };
    self.contentTipView.lbTitle.text = _title;
    self.contentTipView.center = self.center;
    [self addSubview:self.contentTipView];
    self.contentTipView.layer.cornerRadius = 6;
    [self show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)toastWithTitle:(NSString *)title message:(NSString *)message complete:(void (^)())complete{
    WeakSelf;
    self.title = title;
    self.message = message;
    self.frame = [UIScreen mainScreen].bounds;
    //------- 弹窗主内容 -------//
    self.contentTipView = [[BookRemindView alloc]initWithFrame:self.bounds leftBtnTitle:_leftButtonTitle rightBtnTitle:_rightButtonTitle content:_message];
    self.contentTipView.cencelBtn = ^{
        [weakSelf removeFromSuperview];
    };
    self.contentTipView.lbTitle.text = _title;
    self.contentTipView.center = self.center;
    [self addSubview:self.contentTipView];
    self.contentTipView.layer.cornerRadius = 6;
    [self show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        complete();
    });
}

+(void)toastWithTitle:(NSString *)title message:(NSString *)message{
    MzzHud *hud = [[MzzHud alloc] init];
    [hud toastWithTitle:title message:message];
}

+(void)toastWithTitle:(NSString *)title message:(NSString *)message complete:(void (^)())complete{
    MzzHud *hud = [[MzzHud alloc] init];
    [hud toastWithTitle:title message:message complete:complete];
}


/**
 content内容居中
 */
- (void)contentLabelCenter {
    // 当没有title 提示时，content内容居中
    if (self.contentTipView.lbTitle.text == nil || self.contentTipView.lbTitle.text.length <= 0) {
        CGFloat topGap = (self.contentTipView.view.height - self.contentTipView.lbContent.height - 50) / 2.f;
        self.contentTipView.lbContent.frame = CGRectMake(35, topGap, self.contentTipView.view.width - 35 * 2 , 50);
    }
}

@end
