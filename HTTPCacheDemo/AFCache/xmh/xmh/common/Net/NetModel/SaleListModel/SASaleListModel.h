//
//  SASaleListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZheKouModel.h"
#import "SATicketListModel.h"
#import "XMHShoppingCartBaseModel.h"
@class SaleSubModel,PriceListModel,SaleModel;
@interface SASaleListModel : NSObject
@property (nonatomic, strong)NSArray <SaleModel *>* list;
@end

@interface SaleModel : XMHShoppingCartBaseModel
@property (nonatomic, assign)BOOL isShow;
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, assign)NSInteger kill;
@property (nonatomic, copy)NSString * username;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) NSInteger is_have;
@property (nonatomic, assign) NSInteger card_id;
@property (nonatomic, assign) NSInteger user_card_id;

@property (nonatomic, copy)NSString * seckill_price;//秒杀价格
@property (nonatomic, copy)NSString * seckill_date;
@property (nonatomic, copy)NSString * seckill_end;
//@property (nonatomic, copy)NSString * code;
@property (nonatomic, assign)NSInteger shichang;
@property (nonatomic, assign)NSInteger state;
@property (nonatomic, strong)PriceListModel * price_list;
@property (nonatomic, assign)NSInteger toker;
@property (nonatomic, assign)NSInteger expiry;
@property (nonatomic, assign)NSInteger addnum;//添加到购物车的数量
//@property (nonatomic, assign)NSInteger num;
@property (nonatomic, copy)NSString * inputPrice;
@property (nonatomic, copy)NSString * totalPrice;//总价
@property (nonatomic, copy)NSString * totalShangpinYuanJiaPrice;
@property (nonatomic, assign)NSInteger limit;//限制的数量
@property (nonatomic, copy)NSString * ciShu;//项目选中的疗程次数
@property (nonatomic, strong)NSMutableArray *courseNumArr;// 所有疗程次数
@property (nonatomic, strong) NSMutableArray *coursePriceArr;// 所有疗程零售价(包括单次
@property (nonatomic, assign) NSInteger courseIndex;//选中的项目疗程对应的index(eg:0/1/2)
@property (nonatomic, assign)NSInteger mzzAwardCount;// x奖赠数量
@property (nonatomic, assign)NSInteger mzzAwardTotlePrice;//奖增价值

@property (nonatomic, copy)NSString * unit;
@property (nonatomic, strong)ZheKouStored_Card *sastoreCardModel;
@property (nonatomic, strong)SATicketModel *staicketModel;
@property (nonatomic, copy)NSString * baohanJsonStr;
@property (nonatomic, copy)NSString * end_time;//代金券有效期
@property (nonatomic, copy)NSString * cardType;//商品类型对应type(项目、产品、优惠券、特惠券。。。)
@property (nonatomic, copy)NSString *type_name;//商品类型对应名字(项目、产品、优惠券、特惠券。。。)
@property (nonatomic,assign) NSInteger gai_price;//是否修改了价格（修改了价格要给审批流中的人发消息），是：1，否：0

@property (nonatomic, assign)BOOL jiangzhengSelect;

@property (nonatomic, assign)BOOL isBaoHan;
@property (nonatomic, strong)NSString * huiyuanName;//记录选择了会员优惠券
@property (nonatomic, strong)NSString * diyongName;//记录选择了抵用券
@property (nonatomic, strong)NSString * lingshouMoney;//零售价

@property (nonatomic, assign)NSInteger mark;

@property (nonatomic, copy)NSString *store_code;//

@property (nonatomic, assign)CGFloat fieldPrice;//输入框输入的价格 dy

//@property (nonatomic, copy) NSString *coursePrice;//选中的项目疗程对应的价格
@property (nonatomic, assign) XMHSaleOrderType saleOederType;//卡项类型

@property (nonatomic, copy) NSString *xm_discount;// 商品折扣
@property (nonatomic, copy) NSString *cp_discount;// 产品折扣


/**
 计算总价格
 */
- (CGFloat)computeTotalPrice;

@end

@interface PriceListModel : NSObject
@property (nonatomic, strong)SaleSubModel * pro_11;//单次零售价{@"num":XX,@"price":@"XX"}
@property (nonatomic, strong)SaleSubModel * pro_12;//单次会员价{@"num":XX,@"price":@"XX"}
@property (nonatomic, strong)SaleSubModel * pro_21;//疗程成交价{@"num":XX,@"price":@"XX"}
@property (nonatomic, strong)SaleSubModel * pro_22;//疗程会员价{@"num":XX,@"price":@"XX"}
@property (nonatomic, strong)SaleSubModel * pro_10;//市场价格{@"num":XX,@"price":@"XX"}
@property (nonatomic, assign)NSInteger is_fixed;//0固定 1不固定 //疗程卡用到
@end

@interface SaleSubModel : NSObject
@property (nonatomic, strong)NSString * num;
@property (nonatomic, strong)NSString * price;
@end
