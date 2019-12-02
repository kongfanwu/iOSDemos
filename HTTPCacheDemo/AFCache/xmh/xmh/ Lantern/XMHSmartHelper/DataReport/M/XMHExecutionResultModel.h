//
//  XMHExecutionResultModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHSmartManagerEnum.h"
#import "XMHCouponListModel.h"
#import "GKGLHomeCustomerListModel.h"

@class XMHExecutionResultModel;
NS_ASSUME_NONNULL_BEGIN


@interface XMHExecutionResultModel : NSObject
/** 任务名称 */
@property (nonatomic, copy)NSString *name;
/** 执行时间 */
@property (nonatomic, copy)NSString *send_date;
/** 执行方式：1 消息 2 优惠券 3 预约 */
@property (nonatomic, copy)NSString *track_method;
/** 追踪顾客人数 */
@property (nonatomic, copy)NSString *all;
/** 发送成功顾客人数 */
@property (nonatomic, copy)NSString *success;
/** 发送失败顾客人数 */
@property (nonatomic, copy)NSString *failure;
/** 执行内容 */
@property (nonatomic, copy)NSString *track_msg;
/** 每人发送几张优惠券 */
@property (nonatomic, copy)NSString *person_send;
/** 优惠券 */
@property (nonatomic, copy)NSString *ticket;
/** 预约顾客 */
@property (nonatomic, strong) NSString *appo_num;
/** 执行预约 */
@property (nonatomic, strong) NSString *zhi_appo_num;
/** 到店人数 */
@property (nonatomic, strong) NSString *daodian;
/** 优惠券数组 */
@property (nonatomic, strong) NSArray <XMHCouponModel *>* ticket_list;
/** 顾客数组 */
@property (nonatomic, strong) NSArray <GKGLHomeCustomerModel *>*user_list;
/** 执行方式类型 */
@property (nonatomic, assign) XMHResultOfExecutionType executionType;

@property (nonatomic, strong) NSString *cellIdentifier;

@end

@interface XMHExecutionResultListModel : NSObject

@property (nonatomic, strong)NSMutableArray <XMHExecutionResultModel *>*list;
/** 任务名称 */
@property (nonatomic, copy)NSString *name;
/** id */
@property (nonatomic, copy)NSString *uid;
/** 时间 */
@property (nonatomic, copy)NSString *create_time;
/** 任务总次数 */
@property (nonatomic, copy)NSString *all;
/** 执行次数 */
@property (nonatomic, copy)NSString *zhi;
@end

NS_ASSUME_NONNULL_END
