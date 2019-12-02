//
//  XMHBillRecoverStatisticVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHBillRecoverStatisticVC : UIViewController
/** 选择k顾客model */
@property (nonatomic, strong) CustomerModel *selectUserModel;
@property (nonatomic, strong)NSMutableArray *dataArr;// 结算统计商品数据
@property (nonatomic, copy) NSString *totalPrice;
@end

NS_ASSUME_NONNULL_END
