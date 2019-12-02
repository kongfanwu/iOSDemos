//
//  TJStaffDetailVC.h
//  xmh
//
//  Created by ald_ios on 2018/12/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
#import "TJCustomerListModel.h"
@interface TJStaffDetailVC : BaseCommonViewController
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, strong)TJCustomerModel * customerModel ;
@end
