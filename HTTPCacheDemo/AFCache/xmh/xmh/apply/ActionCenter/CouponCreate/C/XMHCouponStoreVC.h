//
//  XMHCouponStoreVC.h
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCouponStoreModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponStoreVC : UIViewController
/** default YES */
@property (nonatomic) BOOL edit;
/** 选中的 */
@property (nonatomic, strong) NSMutableArray *selectArray;
/** 保存多选数据集合 是否是全部数据 默认 NO
 如果是 YES 优先级比 selectArray 高
 */
@property (nonatomic, getter=isDataArrayAll) BOOL dataArrayAll;
/** <#type#> */
@property (nonatomic, copy) void (^selectBlock)(NSMutableArray <XMHCouponStoreModel *>* selectList, BOOL isAll);

/* 获取门店列表数据 */
+ (void)getDataComplete:(void(^)(NSArray <XMHCouponStoreModel *> *dataArray))complete;

@end

NS_ASSUME_NONNULL_END
