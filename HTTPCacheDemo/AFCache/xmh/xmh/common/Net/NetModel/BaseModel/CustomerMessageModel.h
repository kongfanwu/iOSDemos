//
//  CustomerMessageModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  顾客基本信息模型

#import <Foundation/Foundation.h>

@interface CustomerMessageModel : NSObject
//用户ID
@property (nonatomic, assign)NSInteger  uid;
//用户姓名
@property (nonatomic, copy)NSString * uname;
//用户手机号码
@property (nonatomic, copy)NSString * mobile;
//用户头像
@property (nonatomic, copy)NSString * headimgurl;
//顾客等级
@property (nonatomic, copy)NSString * grade;
//门店编码
@property (nonatomic, copy)NSString * store_code;
//所属技师
@property (nonatomic, copy)NSString * jis;
//顾客所在门店
@property (nonatomic, copy)NSString * mdname;
//技师姓名
@property (nonatomic, copy)NSString * jis_name;
//商家编码
@property (nonatomic, copy)NSString * join_code;
//商家名称
@property (nonatomic, copy)NSString * join_name;
@property (nonatomic, copy)NSString * last_fw_time;
@property (nonatomic, copy)NSString * show;
@property (nonatomic, copy)NSString * zt;
@property (nonatomic, copy)NSString * insert_time;
@end
