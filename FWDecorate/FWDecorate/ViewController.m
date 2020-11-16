//
//  ViewController.m
//  FWDecorate
//
//  Created by kfw on 2019/9/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//
/*
 什么是装饰者模式：
 装饰者模式，是面向对象编程领域中，一种动态地往一个类中添加新的行为的设计模式。
 就功能而言，修饰模式相比生成子类更为灵活，这样可以给某个对象而不是整个类添加一些功能。——《设计模式：可复用面向对象软件的基础》
 */
#import "ViewController.h"

#import "DiDiCar.h"
#import "BeiJingDecorate.h"
#import "ShangHaiDecorate.h"

@interface ViewController ()
/** <##> */
@property (nonatomic, strong) DiDiCar *car;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.car = DiDiCar.new;
    
    BeiJingDecorate *beiJingDecorate = [[BeiJingDecorate alloc] initWithCarComponent:self.car];
    
    ShangHaiDecorate *shangHaiDecorate = [[ShangHaiDecorate alloc] initWithCarComponent:beiJingDecorate];
    
    [shangHaiDecorate run];
}


@end
