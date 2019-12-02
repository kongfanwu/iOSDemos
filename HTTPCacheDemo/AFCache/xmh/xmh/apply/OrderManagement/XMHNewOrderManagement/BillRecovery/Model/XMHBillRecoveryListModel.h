//
//  XMHBillRecoveryListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XMHBillRecoveryModel;

@interface XMHBillRecoveryListModel : NSObject
@property (nonatomic, strong) NSMutableArray <XMHBillRecoveryModel*>*list;

@end

@interface XMHBillRecoveryModel : NSObject

@property (nonatomic,copy) NSString *type; //类型
@property (nonatomic,copy) NSString *name; //名称

@end

@interface XMHBillRecoveryStatiscModel : NSObject
@property (nonatomic,copy) NSString *name; //回收商品
@property (nonatomic,copy) NSString *num; //回收数量
@property (nonatomic,copy) NSString *price; //回收金额
@property (nonatomic,copy) NSString *type;//类型 pro,goods,card_num,card_time,ticket
@property (nonatomic,copy) NSString *code; //项目cod
@property (nonatomic,assign) NSInteger uid;//账单中的id


@end

NS_ASSUME_NONNULL_END
