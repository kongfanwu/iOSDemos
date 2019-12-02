//
//  TheOneCustomerViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheOneCustomerViewController : UIViewController

@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *join_code;
/** 1、定制处方按钮 2、列表跳转 */
@property(nonatomic, assign) NSInteger from;

@end
