//
//  XMHExperienceOrderContentVC.h
//  xmh
//
//  Created by KFW on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 内容vvc

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"

@class SLS_ProModel, SLGoodListModel, SLSCourseExper, SLCourseExperList;

NS_ASSUME_NONNULL_BEGIN

@interface XMHExperienceOrderContentVC : UIViewController
/** 是否可编辑  NO 不可编辑 默认YES. 用于处理没有选择用户不显示情况*/
@property (nonatomic) BOOL edit;
/** 服务类型 */
@property (nonatomic) XMHExperienceOrderType type;
/** 项目 */
@property (nonatomic, strong) SLS_ProModel *projectModel;
/** 产品 */
@property (nonatomic, strong) SLGoodListModel *goodModel;
/** 体验,特惠卡具体项目，产品model */
@property (nonatomic, strong) SLCourseExperList *courseExperList;
/** 搜索数据源。需要搜索全局项目*/
@property (nonatomic, strong) NSMutableArray *searchDataArray;
/** 选择用户model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
@end

NS_ASSUME_NONNULL_END
