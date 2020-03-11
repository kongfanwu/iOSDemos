//
//  FTSelectVC.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/11.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTSelectVC.h"
#import "FTMenDianModel.h"

@interface FTSelectVC ()

@end

@implementation FTSelectVC

@synthesize row = _row;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.magentaColor;
    
    NSLog(@"title:%@", self.row.title);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FTMenDianModel *model = FTMenDianModel.new;
    model.Id = @"100";
    model.name = @"70";
    self.row.value = model;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - FTFormActionViewControllerProtocol

/**
 配置参数
 
 @param param 参数字典
 */
- (void)confitParam:(NSDictionary *)param {
    NSLog(@"%@", param);
}

@end
