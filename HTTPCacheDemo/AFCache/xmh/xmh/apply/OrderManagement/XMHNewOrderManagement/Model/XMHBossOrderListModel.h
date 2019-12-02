//
//  XMHBossOrderListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class XMHBossOrderModel;

@interface XMHBossOrderListModel : NSObject
@property (nonatomic, strong)NSMutableArray <XMHBossOrderModel *>*list;

@end

@interface XMHBossOrderModel : NSObject

@property (nonatomic,copy) NSString *code;// 门店编码
@property (nonatomic,assign) NSInteger sales_num; //销售单单数
@property (nonatomic,assign) NSInteger serv_num; //服务单单数
@property (nonatomic,assign) NSInteger fram_id; //岗位id
@property (nonatomic,copy) NSString *name; //门店名称
@property (nonatomic,copy) NSString *inId;//账号

@end

NS_ASSUME_NONNULL_END
