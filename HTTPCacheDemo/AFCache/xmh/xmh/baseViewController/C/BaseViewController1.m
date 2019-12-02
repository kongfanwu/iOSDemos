//
//  BaseViewController1.m
//  xmh
//
//  Created by ald_ios on 2018/9/7.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseViewController1.h"
#define kLogoViewH  138
#define kNavViewH  64
@interface BaseViewController1 ()
@end

@implementation BaseViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    //初始化UI
    [self initBaseSubViews];
}
// 添加各种UI
- (void)initBaseSubViews
{   //添加logoView
    [self.view addSubview:self.logoView];
    //添加导航
    [self.view addSubview:self.navView];
}
- (UIImageView *)logoView
{
    if (!_logoView) {
         _logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kLogoViewH)];
        _logoView.image = UIImageName(@"toubudi");
    }
    return _logoView;
}
- (LNavView *)navView
{
    WeakSelf
    if (!_navView) {
        _navView = loadNibName(@"LNavView");
        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav);
        _navView.backgroundColor = [UIColor clearColor];
        _navView.NavViewBackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navView;
}
@end
