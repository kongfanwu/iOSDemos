//
//  BeautyCFReportWriteVC.h
//  xmh
//
//  Created by ald_ios on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  填写处方报告

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BeautyCFReportWriteVC : BaseCommonViewController
@property (nonatomic, strong)NSMutableDictionary * param;
/** 1、来自详情  2、来自列表按钮*/
@property (nonatomic, assign)NSInteger from;
@end

NS_ASSUME_NONNULL_END
