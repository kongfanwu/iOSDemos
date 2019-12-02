//
//  XMHACShareView.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACShareView.h"
@interface XMHACShareView()
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *weixiView;
@property (weak, nonatomic) IBOutlet UIView *pengyouquanView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pengyouquanLeftLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomLayout;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation XMHACShareView
- (IBAction)cancelBtnClick:(id)sender {
    [self dismiss];
}
- (IBAction)weixinBtnClick:(id)sender {
    if (_shareViewOnlick) {
        _shareViewOnlick(0);
    }
}
- (IBAction)pengyouBtnClick:(id)sender {
    if (_shareViewOnlick) {
        _shareViewOnlick(1);
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
   
    self.bgView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    self.bottomView.layer.cornerRadius = 10;
    self.bottomView.layer.masksToBounds = YES;
    self.bottomViewBottomLayout.constant = - 5;
    self.bottomView.backgroundColor = UIColor.whiteColor;
    self.pengyouquanLeftLayout.constant = SCREEN_WIDTH * 0.5;
}
#pragma mark - 弹出此弹窗
/** 弹出此弹窗 */
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.backgroundColor = UIColor.clearColor;;
    self.frame = keyWindow.bounds;
    self.bgView.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}

@end
