//
//  GKGLCustomerInfoEditVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  顾客基本信息编辑界面

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKGLCustomerInfoEditVC : BaseCommonViewController
@property (nonatomic,strong) NSArray *selections; //!< 选择的三个下标
@property (nonatomic,copy) NSString *pushAddress; //!< 展示的地址
@property (nonatomic, strong)NSDictionary * param;
@end

NS_ASSUME_NONNULL_END
