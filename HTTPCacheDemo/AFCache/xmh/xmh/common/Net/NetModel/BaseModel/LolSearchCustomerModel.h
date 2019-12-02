//
//  LolSearchCustomerModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  搜索顾客信息的model

#import <Foundation/Foundation.h>

@interface LolSearchCustomerModel : NSObject
//门店编码
@property (nonatomic, copy)NSString * store_code;
//顾客id
@property (nonatomic, assign)NSInteger user_id;
//顾客等级，0粉丝，1新人，2达人，3会员
@property (nonatomic, assign)NSInteger grade;
//归属技师账号
@property (nonatomic, copy)NSString * jis;
//顾客账号
@property (nonatomic, copy)NSString * account;
//顾客姓名
@property (nonatomic, copy)NSString * user_name;
//顾客手机号
@property (nonatomic, copy)NSString * mobile;
//顾客注册时间
@property (nonatomic, copy)NSString * insert_time;
//顾客头像
@property (nonatomic, copy)NSString * user_headimgurl;
//门店名称
@property (nonatomic, copy)NSString * store_name;
//技师姓名
@property (nonatomic, copy)NSString * jis_name;
@end
