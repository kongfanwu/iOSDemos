//
//  MainViewController.m
//  xmh
//
//  Created by ald_ios on 2018/9/6.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MainViewController.h"
#import "MessageVC.h"
#import "SmarketViewController.h"
#import "WorkViewController.h"
#import "ApplyViewController.h"
#import "MineViewController.h"
#import "LLNavigationController.h"
#import "LanternHomeVC.h"
#import "StatisticsViewController.h"
#import "LanternManagerHomeVC.h"
#import "RolesTools.h"
#import <YYWebImage/YYWebImage.h>
#import <WebKit/WebKit.h>

@interface MainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, strong)YYAnimatedImageView *imgv;
/** <##> */
@property (nonatomic, strong) WorkViewController *work;
@end

@implementation MainViewController
{
    NSMutableArray * _viewControllers;
    BOOL _isManager;
    /** tabber 点击 */
//    NSInteger _selectIndex;
}

- (void)dealloc
{
    self.work = nil;
    MzzLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    if ([RolesTools getUserMainRole] == 1 ||[RolesTools getUserMainRole] == 3||[RolesTools getUserMainRole] == 4||[RolesTools getUserMainRole] == 5||[RolesTools getUserMainRole] == 6||[RolesTools getUserMainRole] == 7) {
//        _isManager = YES;
//    }else{
//        _isManager = NO;
//    }
    self.delegate = self;
    
    // Do any additional setup after loading the view.
    [UITabBar appearance].translucent = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    //添加所有子控制器
    [self setupAllChildController];
    [self setSelectedIndex:2];
    _selectIndex = 2;
    
}

// 设置所有子控制器
- (void)setupAllChildController
{
    // 添加首页
    MessageVC *msg = [[MessageVC alloc] init];
    msg.view.backgroundColor = [UIColor whiteColor];
    
    [self setupOneChildController:msg image:[UIImage imageNamed:@"xiaoxi_weixuan"] selectImage:[UIImage imageNamed:@"xiaoxi_xuanzhong"] withTitle:@"消息"];
    
    // 添加联系人
    LanternHomeVC *lanternHomeVC = [[LanternHomeVC alloc] init];
    lanternHomeVC.view.backgroundColor = [UIColor whiteColor];
    
    LanternManagerHomeVC * lanternManagerHomeVC = [[LanternManagerHomeVC alloc] init];
    lanternManagerHomeVC.view.backgroundColor = kColorE;
   
//    if (_isManager) {
        [self setupOneChildController:lanternManagerHomeVC image:[UIImage imageNamed:@"aishendeng_weixuan"] selectImage:[UIImage imageNamed:@"aishendeng_xuanzhong"] withTitle:@"AI灯神"];
//    }else{
//        [self setupOneChildController:lanternHomeVC image:[UIImage imageNamed:@"aishendeng_weixuan"] selectImage:[UIImage imageNamed:@"aishendeng_xuanzhong"] withTitle:@"AI灯神"];
//    }
   
    // 添加我
    WorkViewController *work = [[WorkViewController alloc] init];
    self.work = work;
    [self setupOneChildController:work image:[UIImage imageNamed:@"huigongzuo_weixuan"] selectImage:[UIImage imageNamed:@"huigongzuo_kuaijierukouxuanzhong"] withTitle:@"会工作"];
    
    // 添加我
    ApplyViewController *apply = [[ApplyViewController alloc] init];
    [self setupOneChildController:apply image:[UIImage imageNamed:@"yingyong_weixuanzhong"] selectImage:[UIImage imageNamed:@"yingyong_xuanzhong"] withTitle:@"应用"];
    
    // 添加我
    MineViewController *mine = [[MineViewController alloc] init];
    
    [self setupOneChildController:mine image:[UIImage imageNamed:@"wode_weixuan"] selectImage:[UIImage imageNamed:@"wode_xuanzhong"] withTitle:@"我的"];
    
}



// 设置一个子控制器
- (void)setupOneChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage withTitle:(NSString *)title
{
    // 设置tabBarItem属性
    vc.title = title;
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *selectedColor = [NSDictionary dictionaryWithObject:[self colorWithHexString:@"f10180"] forKey:NSForegroundColorAttributeName];
    [vc.tabBarItem setTitleTextAttributes:selectedColor forState:UIControlStateSelected];
    if ([title isEqualToString:@"会工作"]) {
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-6, 0, 6, 0);
    }
    [self addChildViewController:vc];
}

- (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    /**每次点击神灯的动画 */
    if (tabBarController.selectedIndex == 1) {
        UIWindow * window =  [UIApplication sharedApplication].keyWindow;
        YYAnimatedImageView *imgv=[YYAnimatedImageView new];
        imgv.userInteractionEnabled = YES;
        NSURL *path = [[NSBundle mainBundle]URLForResource:@"aladdinBg" withExtension:@"gif"];
        imgv.yy_imageURL = path;
        imgv.frame = window.bounds;
        [window addSubview:imgv];
        [imgv addObserver:self forKeyPath:@"currentAnimatedImageIndex" options:NSKeyValueObservingOptionNew context:nil];
        _imgv = imgv;
        [imgv bk_whenTapped:^{
            [imgv removeFromSuperview];
        }];
    }
    if (_selectIndex==2 &&tabBarController.selectedIndex ==2) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Work_AddBtnClick" object:[NSString stringWithFormat:@"%ld",tabBarController.selectedIndex]];
    }
    _selectIndex = tabBarController.selectedIndex;
   
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:@"currentAnimatedImageIndex"]) {
        if (_imgv.currentAnimatedImageIndex == _imgv.animationImages.count) {
            [_imgv removeFromSuperview];
        }
    }

}
@end

