//
//  LanternAddGoodsVC.h
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
@class LanternPlanInfoModel;
@interface LanternAddGoodsVC : BaseCommonViewController
/** 1、销售 2、消耗 */
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, assign)BOOL isEdit;
@property (nonatomic, copy) void (^LanternAddGoodsVCBlock)(NSMutableArray *selectArr);
@property (nonatomic, strong)LanternPlanInfoModel *lanternPlanInfoModel;
@end
