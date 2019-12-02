//
//  BaseCommonViewController.m
//  xmh
//
//  Created by ald_ios on 2018/10/12.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
@interface BaseCommonViewController ()

@end

@implementation BaseCommonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    self.view.backgroundColor = kBackgroundColor;
}
- (LNavView *)navView
{
    WeakSelf
    if (!_navView) {
        _navView = loadNibName(@"LNavView");

        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, KNaviBarHeight);

        _navView.backgroundColor = [UIColor clearColor];
        _navView.NavViewBackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navView;
}
@end
