//
//  DaiYuYueModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/5.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  待预约model

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface DaiYuYueModel : NSObject
//总次数
@property (nonatomic, assign)NSInteger num;
//预约次数
@property (nonatomic, assign)NSInteger numy;
//已做次数
@property (nonatomic, assign)NSInteger num1;
//用户id
@property (nonatomic, copy)NSString * user_id;
//
@property (nonatomic, copy)NSString * m_id;
//类型
@property (nonatomic, copy)NSString * type;
//项目来源
@property (nonatomic, copy)NSString * ly_type;
//单价
@property (nonatomic, copy)NSString * price;
//项目code
@property (nonatomic, copy)NSString * code;
//项目单id
@property (nonatomic, copy)NSString * relation_id;
//项目单编码
@property (nonatomic, copy)NSString * relation_ordernum;
//项目名称 处方名称
@property (nonatomic, copy)NSString * name;
//时长
@property (nonatomic, assign)NSInteger shichang;
//技师姓名
@property (nonatomic, copy)NSString * jis_name;
//用户姓名
@property (nonatomic, copy)NSString * user_name;
//用户头像
@property (nonatomic, copy)NSString * user_headimgurl;
//处方时间
@property (nonatomic, copy)NSString * stime;
//预约处方名称
@property (nonatomic, copy)NSString * pres_string;

@property (nonatomic, copy)NSString * pres_ordernum;

@property (nonatomic, copy)NSString * goods_ordernum;

@property (nonatomic, copy)NSString * goods_id;

@property (nonatomic, assign)BOOL isSelected;
@end
