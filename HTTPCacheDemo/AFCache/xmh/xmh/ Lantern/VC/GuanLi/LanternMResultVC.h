//
//  LanternMResultVC.h
//  xmh
//
//  Created by ald_ios on 2019/2/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  检索结果界面

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,LanternSearchType)
{
    LanternSearchTypeStaff,
    LanternSearchTypeCustomer,
    LanternSearchTypePro
};
@interface LanternMResultVC : BaseCommonViewController
@property (nonatomic, assign) NSInteger searchIndex;
@property (nonatomic, copy) NSString *search_where;
@property (nonatomic, assign) LanternSearchType searchType;
/** 项目检索过来的数据源 */
@property (nonatomic, strong) NSMutableArray *searchDataSource;
/** 员工检索 和 顾客检索过来的数据源 */
@property (nonatomic, strong) NSMutableDictionary * paramDic;
@property (nonatomic, strong) NSMutableArray * storeArr;
/** 弹窗需要的门店数据 */
@property (nonatomic, strong) NSMutableArray * storeParamArr;
/** 弹窗需要的技师数据 */
@property (nonatomic, strong) NSMutableArray * jisParamArr;

@property (nonatomic, strong) NSMutableArray * cardParamArr;
@end

NS_ASSUME_NONNULL_END
