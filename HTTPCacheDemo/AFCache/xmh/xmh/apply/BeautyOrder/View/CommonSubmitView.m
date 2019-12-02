//
//  CommonSubmitView.m
//  xmh
//
//  Created by ald_ios on 2018/11/2.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CommonSubmitView.h"
@interface CommonSubmitView ()

@end
@implementation CommonSubmitView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [_btnSubmit addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
- (void)updateCommonSubmitViewTitle:(NSString *)title
{
    [_btnSubmit setTitle:title forState:UIControlStateNormal];
}
- (void)click
{
    if (_CommonSubmitViewBlock) {
        _CommonSubmitViewBlock();
    }
}
@end
