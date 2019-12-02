//
//  XMHSaleOrderStatisticVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/29.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
@class CustomerModel;
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSaleOrderStatisticVC : BaseCommonViewController
@property (nonatomic, strong) CustomerModel *customer;// 所选择的顾客
@property (nonatomic, strong) NSMutableArray <SaleModel *>*saleModelList;// 购物车数组
@property (nonatomic,copy)NSString *store_code;
@property (nonatomic, copy) NSString *yingfuPrice;// 补齐项目(逆向开单)应付金额
@property (nonatomic, copy) NSString *ordernum;//补齐项目(逆向开单)订单编号
@end

NS_ASSUME_NONNULL_END
