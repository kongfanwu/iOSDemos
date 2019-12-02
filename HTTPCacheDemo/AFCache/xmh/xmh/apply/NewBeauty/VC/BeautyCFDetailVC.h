//
//  BeautyCFDetailVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  处方详情

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN
@interface BeautyCFDetailVC : BaseCommonViewController
@property (nonatomic, strong)NSMutableDictionary * param;
/** 0、 来自顾客总处方进行的   1、来自顾客总处方已完成  2、来自定制处方*/
@property (nonatomic, assign)NSInteger from;
@property (nonatomic, copy)NSString * callBackMsg;
@property (nonatomic, copy) void (^msgBlock)();
@property (nonatomic, copy) void (^gkglBlock)();
/** 美丽定制总处方 */
@property (nonatomic, copy) void (^beautyZCFBlock)();
/** 开处方 */
@property (nonatomic, copy) void (^makeCFBlock)();
@property (nonatomic, copy) void (^gkglBillDetaiCFBlock)();
@end

NS_ASSUME_NONNULL_END
