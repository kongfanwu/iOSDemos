//
//  XMHSalesOrderVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHOpenOederBaseVC.h"


NS_ASSUME_NONNULL_BEGIN
@class CustomerModel;
@interface XMHSalesOrderVC : XMHOpenOederBaseVC
@property (nonatomic, strong) CustomerModel *selectModel; 
@property (nonatomic, copy) NSString *storeCode;// 门店编码
/* 补齐项目必须使用参数**/
@property (nonatomic, copy) NSString *yingfuPrice;// 补齐项目(逆向开单)应付金额
@property (nonatomic, copy) NSString *ordernum;//补齐项目(逆向开单)订单编号

@end

NS_ASSUME_NONNULL_END
