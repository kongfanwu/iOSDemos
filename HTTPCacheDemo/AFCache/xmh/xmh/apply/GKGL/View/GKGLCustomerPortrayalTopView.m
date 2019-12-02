//
//  GKGLCustomerPortrayalTopView.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerPortrayalTopView.h"
@interface GKGLCustomerPortrayalTopView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation GKGLCustomerPortrayalTopView
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_bgView addGestureRecognizer:tap1];
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    if (_GKGLCustomerPortrayalTopViewBlock) {
        _GKGLCustomerPortrayalTopViewBlock();
    }
}
@end
