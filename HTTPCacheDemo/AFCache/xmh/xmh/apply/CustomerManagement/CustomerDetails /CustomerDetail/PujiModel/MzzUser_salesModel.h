//
//  MzzUser_salesModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzBankModel,MzzTicketModel,MzzCard_TimeModel,MzzCard_NumModel,MzzGoodsModel,MzzStored_CardModel,MzzProModel,MzzTicketCouponModel;

@interface MzzUser_salesModel : NSObject

@property (nonatomic, strong) NSArray<MzzTicketModel *> *ticket;

@property (nonatomic, strong) NSArray<MzzCard_NumModel *> *card_num;

@property (nonatomic, strong) NSArray<MzzGoodsModel *> *goods;

@property (nonatomic, strong)NSArray<MzzBankModel *> *bank;

@property (nonatomic, strong) NSArray<MzzStored_CardModel *> *stored_card;

@property (nonatomic, strong) NSArray<MzzCard_TimeModel *> *card_time;

@property (nonatomic, strong) NSArray<MzzProModel *> *pro;
@property (nonatomic, strong) NSArray<MzzTicketCouponModel *> *ticket_coupon;

@end

@interface MzzBankModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, copy) NSString *dj_amount;

@end

@interface MzzTicketModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger num1;

@property (nonatomic, copy) NSString *ly_type;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *ly_type_name;

@property (nonatomic, copy) NSString *yue;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger amount_a;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger fenqi_zt;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *dj_amount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger is_jz;

@end

@interface MzzCard_TimeModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *card_time_code;

@property (nonatomic, copy) NSString *amount_p;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, assign) NSInteger serv_price;

@property (nonatomic, copy) NSString *ly_type_name;

@property (nonatomic, assign) NSInteger day;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, assign) NSInteger fenqi_zt;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *dj_amount;

@property (nonatomic, assign) NSInteger is_jz;

@end

@interface MzzCard_NumModel : NSObject

@property (nonatomic, copy) NSString *state;

@property (nonatomic, assign) NSInteger sales_num;

@property (nonatomic, assign) NSInteger amount_yue;

@property (nonatomic, copy) NSString *ly_type_name;

@property (nonatomic, assign) NSInteger dj_num;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, copy) NSString *amount_a;

@property (nonatomic, assign) NSInteger fenqi_zt;

@property (nonatomic, assign) NSInteger user_card_id;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger pres_money;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger dj_amount;

@property (nonatomic, assign) NSInteger is_jz;

@end

@interface MzzGoodsModel : NSObject

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger buy_num;

@property (nonatomic, copy) NSString *ly_type_name;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, assign) NSInteger fenqi_zt;

@property (nonatomic, assign) NSInteger shengyu_cishu;

@property (nonatomic, copy) NSString *amount_a;

@property (nonatomic, assign) CGFloat dj_amount;

@property (nonatomic, assign) NSInteger is_jz;

@property (nonatomic, assign) NSInteger is_end;

@property (nonatomic, copy) NSString * is_serv;

@end

@interface MzzStored_CardModel : NSObject

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, copy) NSString *ly_type_name;

@property (nonatomic, copy) NSString *dj_amount_wrz;

@property (nonatomic, assign) NSInteger user_card_id;

@property (nonatomic, copy) NSString *stored_card_price;

@property (nonatomic, copy) NSString *stored_card_name;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger fenqi_zt;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, assign) NSInteger dj_amount;

@property (nonatomic, assign) NSInteger is_jz;

@end

@interface MzzProModel : NSObject

@property (nonatomic, copy) NSString *state;

@property (nonatomic, assign) NSInteger dj_num_wrz;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *ly_type_name;

@property (nonatomic, assign) NSInteger dj_num;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, assign) NSInteger fenqi_zt;

@property (nonatomic, copy) NSString *amount_a;

@property (nonatomic, assign) NSInteger pro_id;

@property (nonatomic, assign) NSInteger nums;

@property (nonatomic, assign) NSInteger dj_amount_wrz;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger dj_amount;

@property (nonatomic, assign) NSInteger is_jz;
@end

/** 优惠券 */
@interface MzzTicketCouponModel : NSObject
@property (nonatomic, assign) NSInteger coupon_id;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) NSInteger jh_zt;
@property (nonatomic, copy) NSString *join_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *fulfill;
@end
