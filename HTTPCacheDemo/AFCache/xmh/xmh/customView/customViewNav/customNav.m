//
//  customNav.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "customNav.h"
#import "navLeftBtn.h"

@implementation customNav{
    NSString *_selfTitleStr;
    UIImageView *_leftImageView;
    CGFloat _hight;//
}

- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withRightBtnImag:(NSString *)imagStr{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
        [self initBtnRightwithRightBtnImag:imagStr];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
        [self initBtnLeftwithleftTitleStr:leftTitleStr withleftImageStr:leftImageStr];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftImageStr:(NSString *)leftImageStr withRightStr:(NSString *)rightStr{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
        if (leftImageStr) {
            [self initBtnLeftwithleftImageStr:leftImageStr];
        }
        if (rightStr) {
            [self initBtnRightwithwithRightStr:rightStr];
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftImageStr:(NSString *)leftImageStr withRightStr:(NSString *)rightStr commenColor:(BOOL)is{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
        if (leftImageStr) {
            [self initBtnLeftwithleftImageStr:leftImageStr];
        }
        if (rightStr) {
            [self initBtnRightwithwithRightStr:rightStr isCommen:is];
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr withRightBtnImag:(NSString *)imagStr{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
        [self initBtnLeftwithleftTitleStr:leftTitleStr withleftImageStr:leftImageStr];
        [self initBtnRightwithRightBtnImag:imagStr];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr withRightBtnImag:(NSString *)imagStr withRightBtnTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
//        [self initBtnLeftwithleftTitleStr:leftTitleStr withleftImageStr:leftImageStr];
        [self initBtnLeftwithleftImageStr:leftImageStr];
        [self initBtnRightwithRightBtnImag:imagStr title:title];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titlestr withleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leftImageStr withRightBtnImag:(NSString *)imagStr withRightBtnTitle:(NSString *)title commenColor:(BOOL)is{
    self = [super initWithFrame:frame];
    if (self) {
        _selfTitleStr = titlestr;
        [self initSubviews];
        //        [self initBtnLeftwithleftTitleStr:leftTitleStr withleftImageStr:leftImageStr];
        [self initBtnLeftwithleftImageStr:leftImageStr];
        [self initBtnRightwithRightBtnImag:imagStr title:title isCommen:is];
    }
    return self;
}
- (void)initSubviews{
    self.backgroundColor = [UIColor whiteColor];
    if (IS_IPHONE_X) {
        _hight = 24.f;
    }else{
        _hight = 0;
    }
    _lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 + _hight, self.width - 20, 20)];
    _lbTitle.text = _selfTitleStr;
//    _lbTitle.textColor = [UIColor darkGrayColor];
    _lbTitle.textColor = [UIColor whiteColor];
    _lbTitle.font = FONT_BOLD_SIZE(18);
    [_lbTitle sizeToFit];
    _lbTitle.center = CGPointMake(self.width/2.0, 20+ (44)/2.0 + _hight);
    [self addSubview:_lbTitle];
    
    _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, Heigh_Nav-1, SCREEN_WIDTH, 1)];
    _lineImageView.backgroundColor = kBackgroundColor;
    [self addSubview:_lineImageView];
}
- (void)initBtnLeftwithleftImageStr:(NSString *)leImageStr{
    _btnLet = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *tempimage = [UIImage imageNamed:leImageStr];
    _btnLet.frame = CGRectMake(0, 20 + _hight, 100, 44);
    _leftImageView = [[UIImageView alloc]initWithImage:tempimage];
    _leftImageView.frame = CGRectMake(15, (_btnLet.height - tempimage.size.height)/2.0, tempimage.size.width, tempimage.size.height);
    [_btnLet addSubview:_leftImageView];
    [self addSubview:_btnLet];
}
- (void)initBtnRightwithRightBtnImag:(NSString *)imaStr{
    _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *tempimage = [UIImage imageNamed:imaStr];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH - 60-15, 20 + _hight, 60, 44);
    [_btnRight setImage:tempimage forState:UIControlStateNormal];
    [_btnRight setImage:tempimage forState:UIControlStateHighlighted];
    [self addSubview:_btnRight];
    _btnRight.center = CGPointMake(_btnRight.center.x, _lbTitle.center.y);
}
- (void)initBtnRightwithRightBtnImag:(NSString *)imaStr title:(NSString *)title
{
    _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *tempimage = [UIImage imageNamed:imaStr];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH - 60-35, 20+ _hight, 84, 44);
//    _btnRight.backgroundColor = [UIColor greenColor];
    [_btnRight setImage:tempimage forState:UIControlStateNormal];
    [_btnRight setImage:tempimage forState:UIControlStateHighlighted];
    [self addSubview:_btnRight];
    [_btnRight setTitle:title forState:UIControlStateNormal];
    [_btnRight setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    _btnRight.titleLabel.font = FONT_SIZE(14);
    _btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    _btnRight.center = CGPointMake(_btnRight.center.x, _lbTitle.center.y);
}
- (void)initBtnRightwithRightBtnImag:(NSString *)imaStr title:(NSString *)title isCommen:(BOOL)is
{
    _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *tempimage = [UIImage imageNamed:imaStr];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH - 60-35, 20+ _hight, 84, 44);
    //    _btnRight.backgroundColor = [UIColor greenColor];
    [_btnRight setImage:tempimage forState:UIControlStateNormal];
    [_btnRight setImage:tempimage forState:UIControlStateHighlighted];
    [self addSubview:_btnRight];
    if (is) {
        [_btnRight setTitle:title forState:UIControlStateNormal];
        [_btnRight setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }else{
        [_btnRight setTitle:title forState:UIControlStateNormal];
        [_btnRight setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    }
    _btnRight.titleLabel.font = FONT_SIZE(14);
    _btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
}
- (void)initBtnRightwithwithRightStr:(NSString *)withRightStr{
    _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH - 80-15, 20+ _hight, 80, 44);
    [_btnRight setTitle:withRightStr forState:UIControlStateNormal];
    [_btnRight setTitle:withRightStr forState:UIControlStateSelected];
    _btnRight.titleLabel.font = FONT_SIZE(17);
    _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self addSubview:_btnRight];
}
- (void)initBtnRightwithwithRightStr:(NSString *)withRightStr isCommen:(BOOL)is{
    _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH - 80-15, 20+ _hight, 80, 44);
    [_btnRight setTitle:withRightStr forState:UIControlStateNormal];
    [_btnRight setTitle:withRightStr forState:UIControlStateSelected];
    _btnRight.titleLabel.font = FONT_SIZE(17);
    _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    if (is) {
        [_btnRight setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_btnRight setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    }else{
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    [self addSubview:_btnRight];
}
- (void)initBtnLeftwithleftTitleStr:(NSString *)leftTitleStr withleftImageStr:(NSString *)leImageStr{
//    CGSize size = [leftTitleStr sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    _btnLet = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *tempimage = [UIImage imageNamed:leImageStr];
    _btnLet.frame = CGRectMake(15, 0+ _hight,90, 44);
    [_btnLet setTitle:leftTitleStr forState:UIControlStateNormal];
    [_btnLet setTitle:leftTitleStr forState:UIControlStateHighlighted];
    _btnLet.titleLabel.font = FONT_SIZE(14);
    [_btnLet setTitleColor:RGBColor(153, 153, 153) forState:UIControlStateNormal];
    [_btnLet setTitleColor:RGBColor(153, 153, 153) forState:UIControlStateHighlighted];
    _leftImageView = [[UIImageView alloc]initWithImage:tempimage];
    _leftImageView.frame = CGRectMake(_btnLet.right - 10, (_btnLet.height - tempimage.size.height)/2.0, tempimage.size.width, tempimage.size.height);
    [_btnLet addSubview:_leftImageView];
    [self addSubview:_btnLet];
    _btnLet.center = CGPointMake(_btnLet.center.x, _lbTitle.center.y);
}

@end
