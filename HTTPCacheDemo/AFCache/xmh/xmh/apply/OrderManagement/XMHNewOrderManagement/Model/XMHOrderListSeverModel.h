//
//  XMHOrderListSeverModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XMHOrderSeverModel;

@interface XMHOrderListSeverModel : NSObject

@property (nonatomic, strong)NSMutableArray <XMHOrderSeverModel *>*list;

@end

@interface XMHOrderSeverModel : NSObject

@property (nonatomic, copy)NSString *ID; //服务单id
@property (nonatomic, copy)NSString *ordernum; //服务单号
@property (nonatomic, copy)NSString *zt; //服务单状态 列表状态： 0全部，1待结算，2已结算，3已完成
@property (nonatomic, copy)NSString *inper; //开单人账号
@property (nonatomic, assign)NSInteger type; //服务单类型
@property (nonatomic, copy)NSString *stime; //开单时间
@property (nonatomic, copy)NSString *user_id; //顾客id
@property (nonatomic, copy)NSString *z_price; //服务业绩
@property (nonatomic, copy)NSString *etime; //结算时间
@property (nonatomic, copy)NSString *zt_name; //状态名称
@property (nonatomic, copy)NSString *type_name; //开单类型
@property (nonatomic, copy)NSString *inper_name; //开单人
@property (nonatomic, copy)NSString *user_name; //顾客姓名
@property (nonatomic, copy)NSString *mobile; //顾客手机号
@property (nonatomic, copy)NSString *img; //是否有服务记录，1有，0没有（显示服务记录按钮）
@property (nonatomic, strong)NSArray *pro_list; //项目名称
@property (nonatomic, strong)NSArray *goods_list; //产品名称
@property (nonatomic, copy)NSString * store_code;
@end
NS_ASSUME_NONNULL_END
