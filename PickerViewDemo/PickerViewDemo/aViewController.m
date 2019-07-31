//
//  aViewController.m
//  PickerViewDemo
//
//  Created by kfw on 2019/6/25.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "aViewController.h"
#import "FWView.h"
@interface aViewController ()

@end

@implementation aViewController

- (void)loadView {
    
    FWView *v = [[FWView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = v;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"123");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
