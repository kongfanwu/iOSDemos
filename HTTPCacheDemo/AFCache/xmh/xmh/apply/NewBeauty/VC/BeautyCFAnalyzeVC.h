//
//  BeautyCFAnalyzeVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/28.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  处方分析

#import <UIKit/UIKit.h>
#import "BaseViewController1.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,BeautyPageType){
    BeautyPageTypeDZ,
    BeautyPageTypeGL,
    BeautyPageTypeYG,
    BeautyPageTypeDJLandQT  /** 店经理和前台 */
};
@interface BeautyCFAnalyzeVC : BaseViewController1
@property (nonatomic, assign)BeautyPageType pageType;
@property (nonatomic, copy)NSString * framID;
@property (nonatomic, copy)NSString * account;
@property (nonatomic, assign)NSInteger mainRole;
@end

NS_ASSUME_NONNULL_END
