//
//  CustomerBillAddModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerBillAddModel : NSObject

@property (nonatomic,copy)NSString *join_code;//商家编码
@property (nonatomic,copy)NSString *code;//项目编码
@property (nonatomic,copy)NSString *store_code;//门店编码
@property (nonatomic,assign)NSInteger user_id;//顾客id
@property (nonatomic,copy)NSString *pay_time;//购买时间
@property (nonatomic,assign)NSInteger amount_p;//购买金额
@property (nonatomic,assign)NSInteger amount;//余额
@property (nonatomic,assign)NSInteger num;//购买次数
@property (nonatomic,assign)NSInteger sheng_num;//剩余次数
@property (nonatomic,assign)NSInteger is_serv;//是否可做服务（1：勾选了售后服务,0:没勾选）
@property (nonatomic,copy)NSString *end_time;//截止时间
@property (nonatomic,assign)NSInteger money;//余额
@property (nonatomic,assign)NSInteger denomination;//购买金额

@end
