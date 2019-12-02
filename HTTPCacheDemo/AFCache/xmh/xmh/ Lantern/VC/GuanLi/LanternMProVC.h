//
//  LanternMProVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/30.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  项目筛选

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMProVC : UIViewController
@property (nonatomic,copy)void (^LanternMProVCBlock)(NSString * search_where,NSMutableArray * dataSource);
@property (nonatomic, copy)NSString * searchID;
@end

NS_ASSUME_NONNULL_END
