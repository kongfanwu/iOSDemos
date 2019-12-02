//
//  LFWDNoticeView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/5.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LFWDNoticeView.h"
#import "LNoticeView.h"
#import "OrderReverseBouncedView.h"
@interface LFWDNoticeView()
@property(nonatomic,strong)UIView *backGroundView;
@property(nonatomic,strong)LNoticeView * notice;
@property(nonatomic,strong)OrderReverseBouncedView * reverseBounced;

@end
@implementation LFWDNoticeView
{
    NSString * _title;
    NSString * _content;
    NSString * _input;
    NSString * _leftBtnTitle;
    NSString * _rightBtnTitle;
    LNoticeView * _notice1;
    OrderReverseBouncedView *_reverseView1;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self initBlackGroundView];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}
-(UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _backGroundView.backgroundColor = [UIColor darkGrayColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_backGroundView addGestureRecognizer:tap];
        _backGroundView.alpha = 0.7;
    }
    return _backGroundView;
}
-(LNoticeView *)notice
{
    if (!_notice) {
        _notice = [[[NSBundle mainBundle]loadNibNamed:@"LNoticeView" owner:nil options:nil]lastObject];
        _notice.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30 * 2, 176);
        _notice.center = self.center;
        _notice1 = _notice;
        [_notice.btnCancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_notice.btnGuanBi addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_notice.btnSure addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notice;
}
-(OrderReverseBouncedView *)reverseBounced
{
    if (!_reverseBounced) {
        _reverseBounced = [[[NSBundle mainBundle]loadNibNamed:@"OrderReverseBouncedView" owner:nil options:nil]lastObject];
        _reverseBounced.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30 * 2, 176);
        _reverseBounced.center = self.center;
        _reverseView1 = _reverseBounced;
        [_reverseBounced.closeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_reverseBounced.sureButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reverseBounced;
}
- (void)initBlackGroundView{
    
    [self addSubview:self.backGroundView];

    if ([self.from isEqualToString:@"逆向"]) {
        [self addSubview:self.reverseBounced];
    }else{
        [self addSubview:self.notice];
    }
}
- (void)click:(UIButton *)btn
{
    if (btn.tag == 200) {
        [self tap];
    }else{
        if (_LFWDNoticeViewBlock) {
            _LFWDNoticeViewBlock(btn.tag - 201,_notice.tf.text);
        }
        if (_reverseViewBlock) {
            _reverseViewBlock(btn.tag - 201,_reverseView1.inputTextField.text);
        }
        [self tap];
    }
}
- (void)tap
{
    [self removeFromSuperview];
}
- (void)showWithTitle:(NSString *)title content:(NSString *)content input:(NSString *)input leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle
{
    [self initBlackGroundView];

    _title = title;
    _content = content;
    _input = input;
    _left = leftBtnTitle;
    _right = rightBtnTitle;
    [_notice1 refreashViewTitle:_title content:_content left:_left right:_right input:_input];
}

- (void)showWithTitle:(NSString *)title leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle{
    [self initBlackGroundView];

    _title = title;
    _left = leftBtnTitle;
    _right = rightBtnTitle;
    [_reverseView1 refreashViewTitle:_title left:_left right:_right];
}
@end
