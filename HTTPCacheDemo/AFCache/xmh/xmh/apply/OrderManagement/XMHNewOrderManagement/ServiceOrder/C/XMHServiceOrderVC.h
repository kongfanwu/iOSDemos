//
//  XMHServiceOrderVC.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 服务制单

#import "BaseCommonViewController.h"
@class CustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderVC : BaseCommonViewController
/**
 配置用户并搜索数据
 */
- (void)confitSelectUserModel:(CustomerModel *)selectUserModel;
@end

NS_ASSUME_NONNULL_END
