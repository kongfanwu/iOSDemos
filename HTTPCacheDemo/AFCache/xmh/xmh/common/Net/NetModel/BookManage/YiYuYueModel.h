//
//  YiYuYueModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  已预约model

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface YiYuYueModel : NSObject
//顾客姓名
@property (nonatomic, copy)NSString * user_name;
//预约日期
@property (nonatomic, copy)NSString * appo_data;
//预约时间
@property (nonatomic, copy)NSString * appo_time;
//预约技师
@property (nonatomic, copy)NSString * pro_string;
//头像地址
@property (nonatomic, copy)NSString * user_headimgurl;
//技师姓名
@property (nonatomic, copy)NSString * jis_name;
//订单编号
@property (nonatomic, copy)NSString * ordernum;
//顾客id
@property (nonatomic, copy)NSString * user_id;
/** 门店编码 */
@property (nonatomic, copy)NSString * store_code;
/** 门店名称 */
@property (nonatomic, copy)NSString * store_name;
/** 用户手机号码 */
@property (nonatomic, copy)NSString * user_mobile;
@end


