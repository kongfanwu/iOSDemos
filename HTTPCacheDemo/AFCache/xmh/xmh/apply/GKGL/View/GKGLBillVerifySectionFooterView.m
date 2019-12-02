//
//  GKGLBillVerifySectionFooterView.m
//  xmh
//
//  Created by ald_ios on 2019/1/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLBillVerifySectionFooterView.h"
@interface GKGLBillVerifySectionFooterView ()
@property (weak, nonatomic) IBOutlet UIView *view;

@end
@implementation GKGLBillVerifySectionFooterView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _view.layer.cornerRadius = 5;
    _view.layer.masksToBounds = YES;
    self.layer.masksToBounds = YES;
}
@end
