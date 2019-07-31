//
//  XMHSelectVC.m
//  XLFormDemo
//
//  Created by KFW on 2019/5/29.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "XMHSelectVC.h"
#import <MapKit/MapKit.h>

@interface XMHSelectVC ()

@end

@implementation XMHSelectVC

@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.purpleColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"add" style:0 target:self action:@selector(validateForm:)];
}

- (void)validateForm:(id)a {
    self.rowDescriptor.value = [[CLLocation alloc] initWithLatitude:-55 longitude:-55];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self dismissViewControllerAnimated:YES completion:nil];
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
