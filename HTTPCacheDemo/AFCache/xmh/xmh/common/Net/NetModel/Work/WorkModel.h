//
//  WorkModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WorkUserModel,WorkTopModel,WorkTodayModel,WorkHeardManagerModel;
@interface WorkModel : NSObject

@property (nonatomic, copy)NSString *state;
@property (nonatomic, copy)NSString *role;//会工作先行接口
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *target;
@property (nonatomic, copy)NSString *complete;
@property (nonatomic, assign)NSInteger deal;
@property (nonatomic, copy)NSString *active;
@property (nonatomic, strong)NSArray <WorkUserModel *>*list;
@property (nonatomic, strong)NSArray <WorkTopModel *>*top;
@property (nonatomic, strong) WorkTodayModel *today;

//会工作领导层头部数据
@property (nonatomic, strong)WorkHeardManagerModel *data;


@end

@interface WorkHeardManagerModel : NSObject
@property (nonatomic, copy)NSString *ach_d;//今日业绩
@property (nonatomic, copy)NSString *ach_m;//月累计
@property (nonatomic, copy)NSString *exp_d;//今日消耗
@property (nonatomic, copy)NSString *exp_m;//月累计消耗
@property (nonatomic, copy)NSString *num_d;//今日客次
@property (nonatomic, copy)NSString *num_m;//月累计客次
@property (nonatomic, copy)NSString *pro_d;//今日项目数
@property (nonatomic, copy)NSString *pro_m;//月累计项目数
@property (nonatomic, copy)NSString *appo;//今日预约
@property (nonatomic, copy)NSString *valid;//今日有效客
@property (nonatomic, copy)NSString *drain;//今日引流
@property (nonatomic, copy)NSString *admit;//人均接待
@property (nonatomic, copy)NSString *handl;//人均操作
@property (nonatomic, copy)NSString *equal;//客均项目
@property (nonatomic, copy)NSString *price;//客均单价
@property (nonatomic, copy)NSString *num_bz;//今日客次标准
@property (nonatomic, copy)NSString *pro_bz;//今日项目数标准


@property (nonatomic, copy)NSString *app_d;//今日预约
@property (nonatomic, copy)NSString *app_m;//月累计预约
@property (nonatomic, copy)NSString *appo_bz;//今日预约标准
@property (nonatomic, copy)NSString *debt_d;//今日总欠款顾客数
@property (nonatomic, copy)NSString *debt_m;//月累计总欠款顾客数
@property (nonatomic, copy)NSString *fund_d;//今日应收款
@property (nonatomic, copy)NSString *fund_m;//月累计应收款
@property (nonatomic, copy)NSString *pres_bz;//今日处方标准

@property (nonatomic, copy)NSString *con_d;//今日处方规划消耗
@property (nonatomic, copy)NSString *con_m;//月累计处方规划消耗
@property (nonatomic, copy)NSString *tok_d;//今日拓客人数
@property (nonatomic, copy)NSString *tok_m;//月累计拓客人数
@property (nonatomic, copy)NSString *dea_d;//今日成交
@property (nonatomic, copy)NSString *dea_m;//月累计成交
@property (nonatomic, copy)NSString *rate;//成交率
@property (nonatomic, copy)NSString *tok_bz;//今日拓客标准
@property (nonatomic, copy)NSString *dea_bz;//今日成交标准

@property (nonatomic, copy)NSString *try_d;//今日试做
@property (nonatomic, copy)NSString *try_m;//月累计试做

@property (nonatomic, copy)NSString *toker;//今日拓客
@property (nonatomic, copy)NSString *try_;//今日试做
@property (nonatomic, copy)NSString *deal;//今日成交
@property (nonatomic, copy)NSString *achie;//今日业绩
@property (nonatomic, copy)NSString *target;//目标客户
@property (nonatomic, copy)NSString *consume;//零消费顾客
@property (nonatomic, copy)NSString *total;//总顾客
@property (nonatomic, copy)NSString *aim_n;//标准会员新增
@property (nonatomic, copy)NSString *aim_a;//标准会员累计
@property (nonatomic, copy)NSString *pop_n;//会员新增
@property (nonatomic, copy)NSString *pop_a;//会员累计
@property (nonatomic, copy)NSString *grant_n;//准A新增
@property (nonatomic, copy)NSString *grant_a;//准A累计
@property (nonatomic, copy)NSString *serv;//今日预约服务
@property (nonatomic, copy)NSString *pres;//今日处方
@property (nonatomic, copy)NSString *add;//今日新增
@property (nonatomic, copy)NSString *count;//总累计
@property (nonatomic, copy)NSString *carry;//承接人数
@property (nonatomic, copy)NSString *valid_bz;//今日有效客标准
@property (nonatomic, copy)NSString *drain_bz;//今日引流标准
@property (nonatomic, copy)NSString *admit_bz;//今日人均接待标准
@property (nonatomic, copy)NSString *handl_bz;//今日人均操作标准
@property (nonatomic, copy)NSString *equal_bz;//今日客均项目标准
@property (nonatomic, copy)NSString *price_bz;//今日客均单价标准
@property (nonatomic, copy)NSString *toker_bz;//今日拓客标准
@property (nonatomic, copy)NSString *try_bz;//今日试做标准
@property (nonatomic, copy)NSString *deal_bz;//今日成交标准

@end

@interface WorkUserModel : NSObject
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *user_name;
@property (nonatomic, copy)NSString *user_tel;
@property (nonatomic, copy)NSString *user_img;

@end
@interface WorkTopModel : NSObject
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *target;
@property (nonatomic, copy)NSString * actual;
@end

@interface WorkTodayModel : NSObject
@property (nonatomic, assign)NSInteger appo;
@property (nonatomic, assign)NSInteger serv;
@property (nonatomic, assign)NSInteger toker;
@end
