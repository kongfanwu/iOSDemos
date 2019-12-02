//
//  LNavigationController.m
//  xmh
//
//  Created by ald_ios on 2018/9/6.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LLNavigationController.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


@interface LLNavigationController ()<UINavigationControllerDelegate>

@end

@implementation LLNavigationController

// 第一次用到这个类时使用这个方法，只执行一次
+ (void)initialize{
    
    [super initialize];
    // 设置UIBarButtonItem的属性
    // 获取当前类下得item
    UIBarButtonItem *items = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // item字体的大小
    att[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [items setTitleTextAttributes:att forState:UIControlStateNormal];
    
    
    
    //设置UINavigationBar的属性
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //    bar.translucent = NO;
    //    UIImage *barImage = [UIImage imageWithColor:[DiffUtil getDifferColor] andSize:bar.bounds.size];
    //    [bar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    
    [bar setBarTintColor:[UIColor whiteColor]];
    
    [bar setTintColor:[UIColor blackColor]];
    
    NSMutableDictionary *barAtt = [NSMutableDictionary dictionary];
    // 设置标题的字体
    barAtt[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    // 设置标题的颜色（前景色）
    barAtt[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    //设置item的颜色
    [bar setTitleTextAttributes:barAtt];
    
    // 设置状态栏格式
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
}

//- (UIViewController *)childViewControllerForStatusBarStyle
//{
//    return self.topViewController;
//}

// 推出下一个界面时都会调用这个方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.delegate = nil;
    
    if (self.childViewControllers.count) {// 非根控制器
        // 隐藏底部的tabbar
//        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置非控制器，左侧返回右侧返回根控制器按钮图片
        UIImage *image = [[UIImage imageNamed:@"back_icon_def"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backPre)];
        
        viewController.navigationItem.leftBarButtonItem = back;
    }
    
    // 调用父类的方法才会实现推出下一个界面的效果
    [super pushViewController:viewController animated:YES];
    
}

// 返回上一个界面
- (void)backPre
{
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断控制器是否为根控制器
    if (self.childViewControllers.count) {
        //将保存的代理赋值回去,让系统保持原来的侧滑功能
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //将系统的代理保存(在view加载完毕就赋值--->viewDidLoad)
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
#pragma clang diagnostic pop
