//
//  CustomerListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomerModel;
@interface CustomerListModel:NSObject
@property (nonatomic ,copy)NSString *start_date;
@property (nonatomic ,copy)NSString *end_date;
@property (nonatomic ,strong)NSMutableArray<CustomerModel *> *list;
@end

@interface CustomerModel : NSObject
////姓名
//@property (nonatomic,copy)NSString *name;
////等级
//@property (nonatomic,copy)NSString *level;
////门店
//@property (nonatomic,copy)NSString *store;
////技师
//@property (nonatomic,copy)NSString *waiter;
////调至门店
//@property (nonatomic,copy)NSString *to;
////调至门店类型
//@property (nonatomic,copy)NSString *toType;
//
////顾客状态
//@property (nonatomic,assign)NSInteger status;
////头像
//@property (nonatomic,copy)NSString *iconUrl;
//
////手机号
//@property (nonatomic,copy)NSString *mobile;
////uid
//@property (nonatomic,assign)NSInteger uid;
////最后到店时间
//@property (nonatomic,copy)NSString *last_fw_time;
//@property (nonatomic,copy)NSString *store_code;
//@property (nonatomic,copy)NSString *join_code;
//@property (nonatomic,copy)NSString *join_name;

@property (nonatomic, assign) NSInteger uid;
/** 技师账号 */
@property (nonatomic, copy) NSString *jis;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, copy) NSString *join_name;

@property (nonatomic, copy) NSString *headimgurl;
/** 门店编码 */
@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, assign) NSInteger bfb;

@property (nonatomic, assign) NSInteger grade;
/** 等级名称 */
@property (nonatomic, copy) NSString *grade_name;

@property (nonatomic, copy) NSString *last_fw_time;

@property (nonatomic, copy) NSString *mdname;

@property (nonatomic, copy) NSString *tdname;

@property (nonatomic, copy) NSString *tdtype;

@property (nonatomic, assign) BOOL seleted;

/** 显示消费时间 */
@property (nonatomic, copy) NSString *user_headimgurl;

/**
 返回 mobile 字段安全手机号。
 
 @return string
 */
- (NSString *)safeMobile;

/**
 判断顾客是否有归属技师
 
 @return YES 有
 */
- (BOOL)isUserExistJishi;

@end
