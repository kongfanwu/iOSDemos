//
//  LMsgNavView.m
//  xmh
//
//  Created by ald_ios on 2018/8/31.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LNavView.h"
@interface LNavView ()

@end
@implementation LNavView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [_btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = kBtn_Commen_Color;
    self.rightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    self.btnBack.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
}
- (void)setNavViewTitle:(NSString *)title
{
//    [self setNavViewTitle:title titleImage:nil];
    [self setNavViewLeftBtnShow:NO middleTitle:title middleImgName:nil rightTitle:nil];
}
- (void)setNavViewTitle:(NSString *)title titleImage:(NSString *)titleImage
{
//    [_btnTitle.titleLabel sizeToFit];
//    [_btnTitle setTitle:title forState:UIControlStateNormal];
//    [_btnTitle setImage:UIImageName(titleImage) forState:UIControlStateNormal];
//    [_btnTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, -_btnTitle.imageView.width - 20, 0, _btnTitle.imageView.width)];
//    [_btnTitle setImageEdgeInsets:UIEdgeInsetsMake(0, _btnTitle.titleLabel.width, 0, -_btnTitle.titleLabel.width)];
//    [_btnTitle addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self setNavViewLeftBtnShow:NO middleTitle:title middleImgName:titleImage rightTitle:nil];
}
- (void)setNavViewTitle:(NSString *)title backBtnShow:(BOOL)show
{
//    [self setNavViewTitle:title titleImage:nil];
//    _btnBack.hidden = !show;
     [self setNavViewLeftBtnShow:show middleTitle:title middleImgName:nil rightTitle:nil];
}
- (void)click
{
    if (_NavViewBlock) {
        _NavViewBlock();
    }
}
- (void)back
{
    if (_NavViewBackBlock) {
        _NavViewBackBlock();
    }
}
- (void)setNavViewTitle:(NSString *)title backBtnShow:(BOOL)show rightBtnTitle:(NSString *)rightTitle
{
//    [self setNavViewTitle:title titleImage:nil];
//    _btnBack.hidden = !show;
//    if (rightTitle) {
//        [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
//        [_btnTitle addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
//    }else{
//        _rightBtn.hidden = YES;
//    }
    [self setNavViewLeftBtnShow:show middleTitle:title middleImgName:nil rightTitle:rightTitle];
}
- (void)setNavViewTitle:(NSString *)title backBtnShow:(BOOL)show rightBtnImage:(NSString *)imageStr
{
    [self setNavViewLeftBtnShow:show middleTitle:title middleImgName:@"" rightTitle:@"" rightImage:imageStr];
}
- (void)rightClick
{
    if (_NavViewRightBlock) {
        _NavViewRightBlock();
    }
}
- (void) setNavViewLeftBtnShow:(BOOL)LeftShow middleTitle:(NSString *)middleTItle middleImgName:(NSString *)middleImgName rightTitle:(NSString *)rightTitle
{
    if (LeftShow) {
        _btnBack.hidden = !LeftShow;
    }
    if (middleImgName) {
        [_btnTitle.titleLabel sizeToFit];
        [_btnTitle setTitle:middleTItle forState:UIControlStateNormal];
        [_btnTitle setImage:UIImageName(middleImgName) forState:UIControlStateNormal];
        [_btnTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, -_btnTitle.imageView.width - 20, 0, _btnTitle.imageView.width)];
        [_btnTitle setImageEdgeInsets:UIEdgeInsetsMake(0, _btnTitle.titleLabel.width, 0, -_btnTitle.titleLabel.width)];
        [_btnTitle addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }else{
         [_btnTitle setTitle:middleTItle forState:UIControlStateNormal];
    }
    if (rightTitle) {
        _rightBtn.hidden = NO;
        [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        _rightBtn.hidden = YES;
    }
    self.backgroundColor = kColorTheme;
}
- (void)setNavViewLeftBtnShow:(BOOL)LeftShow middleTitle:(NSString *)middleTItle middleImgName:(NSString *)middleImgName rightTitle:(NSString *)rightTitle rightImage:(NSString *)imgStr
{
    if (LeftShow) {
        _btnBack.hidden = !LeftShow;
    }
    if (middleImgName) {
        [_btnTitle.titleLabel sizeToFit];
        [_btnTitle setTitle:middleTItle forState:UIControlStateNormal];
        [_btnTitle setImage:UIImageName(middleImgName) forState:UIControlStateNormal];
        [_btnTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, -_btnTitle.imageView.width - 20, 0, _btnTitle.imageView.width)];
        [_btnTitle setImageEdgeInsets:UIEdgeInsetsMake(0, _btnTitle.titleLabel.width, 0, -_btnTitle.titleLabel.width)];
        [_btnTitle addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_btnTitle setTitle:middleTItle forState:UIControlStateNormal];
    }
    if (rightTitle) {
        _rightBtn.hidden = NO;
        [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        _rightBtn.hidden = YES;
    }
    if (imgStr) {
        _rightBtn.hidden = NO;
        [_rightBtn setImage:UIImageName(imgStr) forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }else{
        _rightBtn.hidden = YES;
    }
    self.backgroundColor = kColorTheme;
}

@end
