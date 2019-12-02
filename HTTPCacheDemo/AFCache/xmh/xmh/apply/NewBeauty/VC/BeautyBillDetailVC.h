//
//  BeautyBillDetailVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  顾客账单明细

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BeautyBillDetailVC : BaseCommonViewController
@property (nonatomic, copy)NSString * userID;
@property (nonatomic, strong)NSMutableDictionary * userParam;
@end

NS_ASSUME_NONNULL_END
