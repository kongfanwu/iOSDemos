//
//  GKGLCustomerBillTopView.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerBillTopView.h"
@interface GKGLCustomerBillTopView ()
@property (weak, nonatomic) IBOutlet UIView *viewLeft;
@property (weak, nonatomic) IBOutlet UIView *viewRight;

@end
@implementation GKGLCustomerBillTopView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _viewLeft.tag = 2000;
    _viewRight.tag = 2001;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_viewLeft addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [_viewRight addGestureRecognizer:tap2];
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 2000) {
        if (_GKGLCustomerBillTopViewAddBillBlock) {
            _GKGLCustomerBillTopViewAddBillBlock();
        }
    }
    if (tap.view.tag == 2001) {
        if (_GKGLCustomerBillTopViewCustomerOrderBlock) {
            _GKGLCustomerBillTopViewCustomerOrderBlock();
        }
    }
    
}
@end
