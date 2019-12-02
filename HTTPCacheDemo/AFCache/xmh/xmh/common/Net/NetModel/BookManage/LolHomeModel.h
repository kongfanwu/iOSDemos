//
//  LolHomeModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  首页统计列表model

#import <Foundation/Foundation.h>
@class LGuKeDetail;
@interface LolHomeModel : NSObject
//美容师名字(店长、美容师)门店名字(店经理) 层级名称（领导）
@property (nonatomic, strong)NSString * name;
//领导层 管理门店数 / 店经理 管理员工数
@property (nonatomic, assign)NSInteger count;
//预约服务人数
@property (nonatomic, assign)NSInteger num;
//预约服务项目数
@property (nonatomic, assign)NSInteger pro_num;
//1休息2达标3不达标
@property (nonatomic, assign)NSInteger state;

@property (nonatomic, strong)NSString * inId;
@property (nonatomic, assign)NSInteger fram_id;
@property (nonatomic, assign)NSInteger fram_name_id;
@property (nonatomic, copy)NSString * main_role;
@property (nonatomic, copy)NSMutableArray<LGuKeDetail *> * pro;
@end


@interface LGuKeDetail : NSObject
/** 预约项目名称 */
@property (nonatomic, strong)NSString * pro_name;
/** 时间 */
@property (nonatomic, strong)NSString * day;
/** 顾客姓名 */
@property (nonatomic, strong)NSString * user_name;
/** 订单号 */
@property (nonatomic, strong)NSString * ordernum;
/** 顾客ID */
@property (nonatomic, assign)NSInteger user_id;
@end
