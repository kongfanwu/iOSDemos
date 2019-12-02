//
//  ViewController.m
//  FWDecorate
//
//  Created by kfw on 2019/9/16.
//  Copyright © 2019 神灯智能. All rights reserved.
//

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
