//
//  BookRemindView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookRemindView.h"

@implementation BookRemindView{
    
    NSString * _contentText;
    NSString * _leftBtnTitle;
    NSString * _rightBtnTitle;
    NSString * _oneBtnTitle;
    UILabel * lbContent;
    NSString *text;
    
}

@synthesize lbContent = lbContent;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame oneBtnTitle:(NSString *)title content:(NSString *)contentText
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _contentText = contentText;
        _oneBtnTitle = title;
        [self initSubViews];
        [self initOneBtn];
    }
    return self;
}
- (void)afterFreshHeight:(NSInteger)height
{
    _view.height = height;
    _btnCenter.frame  = CGRectMake(33, height - 25 - 40 , _view.width - 33 *2, 40);
    lbContent.frame = CGRectMake(35, _lbTitle.bottom + 20, _view.width - 35 * 2 , _btnCenter.y-10 - _lbTitle.bottom-20);
    lbContent.textAlignment = NSTextAlignmentLeft;
}
- (instancetype)initWithFrame:(CGRect)frame leftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle content:(NSString *)contentText
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftBtnTitle = leftTitle;
        _rightBtnTitle = rightTitle;
        _contentText = contentText;
        [self initSubViews];
        [self initLeftBtnrightBtn];
    }
    return self;
}
- (void)initBlackGroundView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    view.backgroundColor = kColor3;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [view addGestureRecognizer:tap];
    view.alpha = 0.4;
    [self addSubview:view];

    
}
- (void)refreshTitleFrame
{
     _lbTitle.frame = CGRectMake(0, _view.height -125, _view.width, _lbTitle.height);
}
- (void)tap{
    
    [self removeFromSuperview];
}

- (void)initSubViews{
    
    [self initBlackGroundView];
    // 容器
    _view = [[UIView alloc] initWithFrame:CGRectMake((self.width - 280)/2, (SCREEN_HEIGHT - 176)/2, 280, 176)];
    _view.backgroundColor = [UIColor whiteColor];
    _view.layer.cornerRadius = 10;
    _view.layer.masksToBounds = YES;
    [self addSubview:_view];
    _lbTitle = [[UILabel alloc] init];
    _lbTitle.textColor = kLabelText_Commen_Color_3;
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    _lbTitle.font = FONT_SIZE(20);
    _lbTitle.text = @"平台提醒";
    [_lbTitle sizeToFit];
    _lbTitle.frame = CGRectMake(0, 20, _view.width, _lbTitle.height);
    
    [_view addSubview:_lbTitle];
    
    lbContent = [[UILabel alloc] init];
//    lbContent.backgroundColor = [UIColor greenColor];
    lbContent.textColor = kLabelText_Commen_Color_6;
    lbContent.font = FONT_SIZE(14);
    lbContent.text = _contentText;
    lbContent.numberOfLines = 0;
    lbContent.lineBreakMode = NSLineBreakByCharWrapping;
    lbContent.textAlignment = NSTextAlignmentCenter;
//    [lbContent sizeToFit];
    lbContent.frame = CGRectMake(35, _lbTitle.bottom + 20, _view.width - 35 * 2 , 50);
    [_view addSubview:lbContent];
    if (!_leftBtnTitle) {
        return;
    }
    if (!_rightBtnTitle) {
        return;
    }
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnCancel setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    _btnCancel.frame = CGRectMake(_view.width - 19 - 15, 19, 15, 15);
    [_btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:_btnCancel];
}

- (void)initOneBtn{
    
    _btnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnCenter setTitle:_oneBtnTitle forState:UIControlStateNormal];
    _btnCenter.titleLabel.font = FONT_SIZE(17);
    [_btnCenter setTitleColor:kColorTheme forState:UIControlStateNormal];
    _btnCenter.frame = CGRectMake(33, _view.height - 49 , _view.width - 33 *2, 49);
    _btnCenter.tag = 0;
//    [_btnCenter addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:_btnCenter];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _btnCenter.frame.origin.y-1, _view.frame.size.width, 1)];
    lineView.backgroundColor = kSeparatorLineColor;
    [_view addSubview:lineView];
    
}
- (void)initLeftBtnrightBtn{
    if (!_leftBtnTitle) {
        return;
    }
    if (!_rightBtnTitle) {
        return;
    }
    UIButton * btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnleft.layer.borderColor = kBtn_Commen_Color.CGColor;
//    btnleft.layer.borderWidth = 1;
    [btnleft setTitle:_leftBtnTitle forState:UIControlStateNormal];
    btnleft.titleLabel.font = FONT_SIZE(17);
    [btnleft setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    btnleft.frame= CGRectMake(15, _view.height - 50, (_view.width - 15 * 2 - 10)/2, 40);
    btnleft.layer.cornerRadius = 3;
    _btnLeft = btnleft;
    [_view addSubview:btnleft];
    btnleft.tag =0;
    
    UIButton * btnright = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnright.backgroundColor = kBtn_Commen_Color;
    [btnright setTitle:_rightBtnTitle forState:UIControlStateNormal];
    btnright.titleLabel.font = FONT_SIZE(17);
    btnright.frame= CGRectMake(btnleft.right + 10, _view.height - 50, (_view.width - 15 * 2 - 10)/2, 40);
//    btnright.layer.cornerRadius = 3;
    [btnright setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    _btnRight = btnright;
    [_view addSubview:btnright];
    btnright.tag =1;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, btnleft.frame.origin.y-1, _view.frame.size.width, 1)];
    lineView.backgroundColor = kSeparatorLineColor;
    [_view addSubview:lineView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(_view.width/2-0.5, lineView.frame.origin.y+1, 1, _view.frame.size.height-lineView.frame.origin.y-1)];
    line.backgroundColor = kSeparatorLineColor;
    [_view addSubview:line];

}
- (void)cancel{
    if (self.cencelBtn) {
        self.cencelBtn();
    }
    [self removeFromSuperview];
}
@end
