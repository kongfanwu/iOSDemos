//
//  LanternMBottomView.m
//  xmh
//
//  Created by ald_ios on 2019/2/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMBottomView.h"
@interface LanternMBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@end
@implementation LanternMBottomView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _btnLeft.layer.cornerRadius = 3;
    _btnLeft.layer.masksToBounds = YES;
    _btnRight.layer.cornerRadius = 3;
    _btnRight.layer.masksToBounds = YES;
}
- (IBAction)reset:(UIButton *)sender
{
    if (_LanternMBottomViewResetBlock) {
        _LanternMBottomViewResetBlock();
    }
}
- (IBAction)search:(UIButton *)sender
{
    if (_LanternMBottomViewSearchBlock) {
        _LanternMBottomViewSearchBlock();
    }
}
- (void)updateTitleLeft:(NSString *)left right:(NSString *)right
{
    [_btnLeft setTitle:left forState:UIControlStateNormal];
    [_btnRight setTitle:right forState:UIControlStateNormal];
}
@end
