//
//  TJDataView.h
//  xmh
//
//  Created by ald_ios on 2018/11/27.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJBBTopModel,TJCustomerTopModel,TJCustomerActiveTopModel,TJExpendTopModel,TJCashTopModel,CustomerRetainTopModel;
@interface TJDataView : UIView
@property (nonatomic, copy)void (^TJDataViewMoreBlock)(BOOL isMore);
/** 业绩报表跟新数据 */
- (void)updateTJDataViewBBModel:(TJBBTopModel *)model;

/** 员工报表跟新数据 */
- (void)updateTJDataViewCustomerModel:(TJCustomerTopModel *)model;

/** 顾客活跃报表跟新数据 */
- (void)updateTJDataViewCustomerActiveModel:(TJCustomerActiveTopModel *)model;

/** 消耗报表头部更新数据 */
- (void)updateTJDataViewExpendModel:(TJExpendTopModel *)model;

/** 收银报表头部更新数据 */
- (void)updateTJDataViewCashModel:(TJCashTopModel *)model;
/** 顾客保有报表头部更新数据 */
- (void)updateTJDataViewCustomerRetainModel:(CustomerRetainTopModel *)model;
/** 项目 更新数据 */
- (void)updateTJDataViewProParam:(NSDictionary *)param;
@end
