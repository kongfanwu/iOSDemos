//
//  BeautyCFBiaoStoreVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  处方表--门店列表

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BeautyCFBiaoStoreVC : BaseCommonViewController
@property (nonatomic, copy) void (^BeautyCFBiaoStoreVCBlock)(NSMutableDictionary *storeParam);
@end

NS_ASSUME_NONNULL_END
