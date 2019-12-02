//
//  XMHCredentiaModel.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 凭证管理 用于处理销售凭证/服务凭证下的状态数据

#import <Foundation/Foundation.h>
#import "XMHCredentiaOrderStateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaModel : NSObject
/** 销售状态 服务状态 */
@property (nonatomic, assign) enum XMHCredentiaItemViewType type;

/**
 获取销售凭证 订单状态集合
 列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'
 */
@property (nonatomic, strong) NSArray <XMHCredentiaOrderStateItemModel *> *saleOrderStateList;

/**
 获取服务凭证 订单状态集合
 列表状态： 0全部，1待结算，2已结算，3已完成
 */
@property (nonatomic, strong) NSArray <XMHCredentiaOrderStateItemModel *> *serviceOrderStateList;

- (NSArray <XMHCredentiaOrderStateItemModel *>*)currentOrderStateList;

/** 数量数组 */
@property (nonatomic, strong) NSArray *badgeArr;

/**
 当前订单状态model
 */
- (XMHCredentiaOrderStateItemModel *)currentOrderModel;

@end

NS_ASSUME_NONNULL_END
