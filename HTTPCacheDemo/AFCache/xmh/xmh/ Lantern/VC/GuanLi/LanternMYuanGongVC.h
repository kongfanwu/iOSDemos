//
//  LanternMYuanGongVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  员工筛选

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMYuanGongVC : UIViewController
@property (nonatomic,copy)void (^LanternMYuanGongVCBlock)(NSString * search_where,NSMutableArray * dataSource);
@property (nonatomic, copy)NSString * searchID;
@end

NS_ASSUME_NONNULL_END
