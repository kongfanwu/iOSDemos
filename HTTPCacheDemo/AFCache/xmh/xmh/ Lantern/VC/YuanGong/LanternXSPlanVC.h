//
//  LanternXSPlanVC.h
//  xmh
//
//  Created by ald_ios on 2018/12/27.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//  销售计划

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "LanternHistoryPlanListModel.h"
typedef NS_ENUM(NSUInteger, DetailComeFrome) {
    DetailComeFromeMakePlan,
    DetailComeFromeHistory
};
@interface LanternXSPlanVC : UIViewController
@property (nonatomic, strong)LanternHistoryPlanModel *lanternHistoryPlanModel;
@property (nonatomic, copy)NSString * year;
@property (nonatomic, copy)NSString * date;
@property (nonatomic, assign)DetailComeFrome comeFrom;
@property (nonatomic, copy) void (^LanternXSPlanVCBlock)(NSString *editID,NSString *isSave);
@end
