//
//  LolSkipToDetailMode.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  类型 ghydd=>规划要到店，yyy=>已预约 ，xgyy=>修改预约 ，ahdd=>按时到店 ，wahdd=>未按时到店 ，ghwdd=>规划外到店
//  上面几种类型 跳转到预约详情页  预约详情页需要的数据为 type  ordernum 两个 整合到这个model类

#import <Foundation/Foundation.h>

@interface LolSkipToDetailMode : NSObject
//类型
@property (nonatomic, copy)NSString * type;
//单号
@property (nonatomic, strong)NSString * ordernum;
//顾客id
@property (nonatomic, strong)NSString * user_id;

@property (nonatomic, strong)NSString * to_gd;
@property (nonatomic, strong)NSMutableArray * orderNumArr;
- (instancetype)initWithType:(NSString *)type orderNum:(NSString *)ordernum userId:(NSString *)userId toGd:(NSString *)togd;
@end
