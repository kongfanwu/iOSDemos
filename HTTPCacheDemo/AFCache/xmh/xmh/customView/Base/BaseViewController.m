//
//  BaseViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//     [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    _markView = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, Heigh_View_normal)];
    [_markView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_markView];
    [XMHProgressHUD showGifImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)end{
    [UIView animateWithDuration:0.5 animations:^{
        _markView.alpha = 0;
    }];
    [XMHProgressHUD dismiss];
}
- (void)pop{
    [self end];
}
@end
