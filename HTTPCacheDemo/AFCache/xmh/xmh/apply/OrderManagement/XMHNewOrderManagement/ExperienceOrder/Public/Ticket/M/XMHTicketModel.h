//
//  XMHTicketModel.h
//  xmh
//
//  Created by KFW on 2019/3/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 服务卷model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHTicketModel : NSObject
/** 礼品券唯一标识 */
@property (nonatomic, copy) NSString *mark;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 编码 */
@property (nonatomic, copy) NSString *code;
/** 购买id */
@property (nonatomic, copy) NSString *ID;
/** 是否可用，1是，2否 */
@property (nonatomic, copy) NSString *is_use;
/** 商家名称 */
@property (nonatomic, copy) NSString *join_name;
/** 有效期开始时间 */
@property (nonatomic, copy) NSString *start_time;
/** 有效期到期时间 */
@property (nonatomic, copy) NSString *end_time;

/** <##> */
@property (nonatomic) BOOL select;

/** 自定义唯一id */
@property (nonatomic, copy) NSString *custonId;

/**
 是否可用， YES 可用
 */
- (BOOL)use;

/**
 获取可使用服务卷
 
 @param modelArray 服务卷集合
 @return 可使用服务卷
 */
+ (NSArray *)useModelArray:(NSArray <XMHTicketModel*> *)modelArray;

/**
 获取不可使用服务卷
 
 @param modelArray 服务卷集合
 @return 可使用服务卷
 */
+ (NSArray *)noModelArray:(NSArray <XMHTicketModel*> *)modelArray;
@end

NS_ASSUME_NONNULL_END
