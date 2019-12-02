//
//  XMHMarketShareView.m
//  xmh
//
//  Created by ald_ios on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHMarketShareView.h"
#import "XMHMarketInfoView.h"
@interface XMHMarketShareView ()
@property (nonatomic, strong)XMHMarketInfoView * infoView;
@property (weak, nonatomic) IBOutlet UIView *btnContainer;
@property (weak, nonatomic) IBOutlet UIImageView *weixin;
@property (weak, nonatomic) IBOutlet UIImageView *pengyouquan;
@property (weak, nonatomic) IBOutlet UIImageView *bendi;
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelH;
@property (nonatomic, assign)XMHMarketVCType marketVCType;
@end

@implementation XMHMarketShareView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _infoView = loadNibName(@"XMHMarketInfoView");
    _infoView.layer.cornerRadius = 10;
    _infoView.layer.masksToBounds = YES;
    CGFloat w = SCREEN_WIDTH - 38 * 2;
    CGFloat h = 362 * w /300;
    _infoView.bounds = CGRectMake(0, 0, w, h);
    
    _infoView.left = 38;
    if (IS_IPHONE_X) {
        _infoView.bottom = SCREEN_HEIGHT - _H.constant + 40;
    }else{
       _infoView.bottom = SCREEN_HEIGHT - _H.constant + 60;
    }
    
    [self addSubview:_infoView];
    WeakSelf
    _weixin.userInteractionEnabled = _pengyouquan.userInteractionEnabled = _bendi.userInteractionEnabled = YES;
    [_weixin bk_whenTapped:^{
        [weakSelf tapDown:1];
    }];
    [_pengyouquan bk_whenTapped:^{
        [weakSelf tapDown:2];
    }];
    [_bendi bk_whenTapped:^{
        [weakSelf tapDown:3];
    }];
    
    [_bg bk_whenTapped:^{
        [weakSelf remove];
    }];
    
    if (IS_IPHONE_X) {
//        _cancelBottom.constant = _cancelBottom.constant + kSafeAreaBottom;
        _cancelH.constant = _cancelH.constant + kSafeAreaBottom;
    }
    
}
- (void)tapDown:(NSInteger)index
{
    if (_XMHMarketShareViewBlock) {
        _XMHMarketShareViewBlock(index);
    }
    [self remove];
    
}
- (IBAction)btnClick:(UIButton *)sender {
    [self remove];
}
- (void)remove
{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)updateViewModel:(XMHMarketModel *)model type:(XMHMarketVCType)type
{
    _marketVCType = type;
    [_infoView updateViewModel:model type:type];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_marketVCType == XMHMarketVCTypeVIP) {
        CGFloat w = SCREEN_WIDTH - 75 * 2;
        CGFloat h = 367 * w /225;
        _infoView.bounds = CGRectMake(0, 0, w, h);
        _infoView.left = 75;
        if (IS_IPHONE_X) {
            _infoView.bottom = SCREEN_HEIGHT - _H.constant + 40;
        }else{
            _infoView.bottom = SCREEN_HEIGHT - _H.constant + 60;
        }
    }
}
@end
