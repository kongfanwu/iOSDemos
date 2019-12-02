//
//  FWDAleartVIew.m
//  xmh
//
//  Created by ald_ios on 2019/2/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "FWDAleartVIew.h"
@interface FWDAleartVIew ()
@property (weak, nonatomic) IBOutlet UIView *container;

@end
@implementation FWDAleartVIew
- (void)awakeFromNib
{
    [super awakeFromNib];
    _container.layer.cornerRadius = 10;
    _container.layer.masksToBounds = YES;
}
- (IBAction)detail:(id)sender {
    if (_FWDAleartVIewDetailBlock) {
        _FWDAleartVIewDetailBlock();
    }
    [self removeFromSuperview];
}
- (IBAction)record:(id)sender {
    if (_FWDAleartVIewRecordBlock) {
        _FWDAleartVIewRecordBlock();
    }
    [self removeFromSuperview];
}
- (IBAction)del:(id)sender {
    if (_FWDAleartVIewDelBlock) {
        _FWDAleartVIewDelBlock();
    }
    [self removeFromSuperview];
}

@end
