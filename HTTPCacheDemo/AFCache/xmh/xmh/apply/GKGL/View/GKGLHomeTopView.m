//
//  GKGLHomeTopView.m
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHomeTopView.h"
@interface GKGLHomeTopView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property (weak, nonatomic) IBOutlet UIView *dataView;

@end
@implementation GKGLHomeTopView
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_addView addGestureRecognizer:tap1];
    [_dataView addGestureRecognizer:tap2];
    
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 100) {
        if (_GKGLHomeTopViewAddBlock) {
            _GKGLHomeTopViewAddBlock();
        }
    }
    if (tap.view.tag == 101) {
        if (_GKGLHomeTopViewDataBlock) {
            _GKGLHomeTopViewDataBlock();
        }
    }
}
@end
