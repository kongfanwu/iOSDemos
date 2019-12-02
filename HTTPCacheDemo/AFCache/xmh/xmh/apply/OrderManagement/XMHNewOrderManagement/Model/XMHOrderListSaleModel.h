//
//  XMHOrderListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XMHOrderSaleModel;

@interface XMHOrderListSaleModel : NSObject
@property (nonatomic, strong)NSMutableArray <XMHOrderSaleModel *>*list;

@end

@interface XMHOrderSaleModel : NSObject

@property (nonatomic,assign) NSInteger ID; //订单id
@property (nonatomic,copy) NSString *inper;//手机号
@property (nonatomic,copy) NSString *ordernum; //销售单编码
@property (nonatomic,copy) NSString *insert_time; //开单时间
@property (nonatomic,copy) NSString *type_name; //订单类型
@property (nonatomic,copy) NSString *order_type_name; //订单状态
@property (nonatomic,copy) NSString *saler; //开单人
@property (nonatomic,copy) NSString *user_name; //用户姓名
@property (nonatomic,copy) NSString *amount; //实付金额
@property (nonatomic,copy) NSString *pay_time; //支付时间
@property (nonatomic,copy) NSString *heji;//结算金额
@property (nonatomic,assign)NSInteger type;//销售凭证列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'

@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, copy)NSString * join_code;
@property (nonatomic, copy)NSString * store_code;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * code;

@property (nonatomic, copy)NSString * buying_time;
@property (nonatomic, assign)NSInteger user_id;


@property (nonatomic, copy)NSString * amount_d;
@property (nonatomic, copy)NSString * hk_date;
@property (nonatomic, copy)NSString * sale;
@property (nonatomic, assign)NSInteger pay_zt;
@property (nonatomic, assign)NSInteger order_type;

@property (nonatomic, assign)NSInteger pay_type;

@property (nonatomic, assign)NSInteger next_person;
@property (nonatomic ,assign)BOOL isShow;
@property (nonatomic, copy)NSString * user_mobile;
@property (nonatomic, copy) NSString *grade_name;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *jis_acc;


@end

NS_ASSUME_NONNULL_END
