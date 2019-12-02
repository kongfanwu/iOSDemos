//
//  CustomerActiveDetailVC.h
//  xmh
//
//  Created by ald_ios on 2018/12/10.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//  顾客活跃 顾客详情

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
#import "TJCustomerActiveListModel.h"
@interface CustomerActiveDetailVC : BaseCommonViewController
@property (nonatomic, strong)TJCustomerActiveModel * customerActiveModel;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@end
