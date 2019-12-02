//
//  BeautyCFBiaoCustomerVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  处方表---顾客列表

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BeautyCFBiaoCustomerVC : BaseCommonViewController
/** 技师 */
@property (nonatomic, strong)NSMutableDictionary * param;
/** 技师数组 */
@property (nonatomic, strong)NSMutableArray * jisDataSoucre;
/** 选择的日期 */
@property (nonatomic, copy)NSString * selectDate;
@end

NS_ASSUME_NONNULL_END
