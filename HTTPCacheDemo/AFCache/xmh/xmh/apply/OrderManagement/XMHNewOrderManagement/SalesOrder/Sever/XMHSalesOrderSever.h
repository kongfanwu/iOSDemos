//
//  XMHSalesOrderSever.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHSalesOrderSever : NSObject
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, copy) NSString *storeCode;
/**
 返回列表数据
 */
@property (nonatomic, copy)void (^saleOrderSeverDataArr)(NSMutableArray *dataArr);


/**
 初始化

 @param userId userId 用户id
 @param type type 类型 pro项目,goods产品,card_course特惠卡,card_num任选卡,card_time时间卡,stored_card储值卡, ticket票券 skxk 储值卡充值
 @param storeCode 商家编码
 @return 列表数据
 */
- (instancetype)initUserId:(NSString *)userId type:(NSString *)type storeCode:(NSString *)storeCode;



@end

NS_ASSUME_NONNULL_END
