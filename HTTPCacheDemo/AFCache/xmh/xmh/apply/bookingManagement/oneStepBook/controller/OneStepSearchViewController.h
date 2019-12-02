//
//  OneStepSearchViewController.h
//  xmh
//
//  Created by 李晓明 on 2017/12/2.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  搜索顾客展示界面

#import <UIKit/UIKit.h>
@class CustomerModel;
@interface OneStepSearchViewController : UIViewController
@property (copy, nonatomic)void(^oneStepSearchViewControllerBlock)(CustomerModel * model);
@end
