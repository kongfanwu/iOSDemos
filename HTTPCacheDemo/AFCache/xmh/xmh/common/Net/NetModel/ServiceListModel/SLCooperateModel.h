//
//  SLCooperateModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLCooperate;

@interface SLCooperateModel : NSObject

@property (nonatomic, assign) CGFloat all;

@property (nonatomic, assign) CGFloat shouzhong;

@property (nonatomic, strong) NSArray<SLCooperate *> *list;

@property (nonatomic, assign) CGFloat shouqian;

@property (nonatomic, assign) CGFloat shouhou;

@end
@interface SLCooperate : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, copy)NSString * store_code;

@property (nonatomic, copy) NSString *user_mobile;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy)NSString * buying_time;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *heji;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *amount_d;
@property (nonatomic, copy) NSString *hk_date;
@property (nonatomic, assign) NSInteger pay_zt;
@property (nonatomic, assign) NSInteger order_type;
@property (nonatomic, copy) NSString *inper_name;
@property (nonatomic, assign) NSInteger pay_type;;
@property (nonatomic, copy) NSString *pay_time;
@property (nonatomic, copy) NSString *insert_time;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *order_type_name;
@property (nonatomic, copy) NSString *saler;
@property (nonatomic, copy) NSString *stime;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *z_price;
@property (nonatomic, copy) NSString *zt_name;
@property (nonatomic, copy) NSString *etime;
@end


