//
//  SalePerformanceViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COrganizeModel.h"
#import "BaseCommonViewController.h"
@interface SalePerformanceViewController : BaseCommonViewController
@property (nonatomic, strong)COrganizeModel *model;
@property (nonatomic, strong)NSString *fromStr;
@property (nonatomic, copy)NSString * startTime;
@property (nonatomic, copy)NSString * endTime;
@end
