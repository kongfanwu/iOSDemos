//
//  ServiceTimeViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LolJiShiTimeModel.h"
#import "CustomerMessageModel.h"
//#import "CustomerModel.h"
@interface ServiceTimeViewController : UIViewController
//@property (strong, nonatomic)CustomerModel * customerModel;
@property (strong, nonatomic)CustomerMessageModel * customerModel;
@property (nonatomic, copy) void(^ServiceTimeViewControllerBlock)(LolJiShiTimeModel * model);
@end
