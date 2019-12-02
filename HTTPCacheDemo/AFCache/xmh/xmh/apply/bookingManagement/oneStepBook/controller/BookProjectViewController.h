//
//  BookProjectViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  预约项目界面

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
#import "DaiYuYueModel.h"
#import "CustomerListModel.h"
#import "CustomerMessageModel.h"
@interface BookProjectViewController : BaseCommonViewController
@property (nonatomic, strong)CustomerModel * model;
@property (nonatomic, strong)CustomerMessageModel * cModel;



@property (nonatomic, copy)NSString * userID;
@property (nonatomic, copy) void(^BookProjectViewControllerBlock)(NSMutableArray * modelArr);
@property (nonatomic, copy) void(^BookProjectViewControllerProjectBlock)(NSString * proStr,NSInteger maxTime);
@end
