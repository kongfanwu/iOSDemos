//
//  SABasicTicketModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SATicketModel;
@interface SATicketListModel : NSObject
@property (nonatomic, strong)NSArray <SATicketModel *>* ticket;

@end

@interface SATicketModel : NSObject
@property (nonatomic, copy)NSString * name;//名称
@property (nonatomic, copy)NSString * code;//编码
@property (nonatomic, copy)NSString * money;//可抵扣的金额（type=1，价格直接减）
@property (nonatomic, assign)NSInteger uid;//购买id
@property (nonatomic, copy)NSString * start_time;//有效期开始时间
@property (nonatomic, copy)NSString * end_time;//有效期到期时间
@property (nonatomic,assign)int type;//票券类型：1（老版本票券=>money），3（现金券=>price,fulfill） , 4（折扣券=>discount,fulfill）
@property (nonatomic, copy)NSString * price;//type=3，价格满足fulfill后价格直接减
@property (nonatomic, copy)NSString * fulfill;//需要满足的价格
@property (nonatomic, copy)NSString * discount;//折扣（type=4，7.6折/20元就是价格先乘以（1-0.76），得到的价格与20比较，大于等于20就用价格减去20，否则就是价格减去得到的价格）
@property (nonatomic, assign)NSInteger mark;//抵用券唯一标识
@property (nonatomic, copy)NSString *is_use;//是否可用，1可用，2不可用
@property (nonatomic, copy)NSString *join_name;//商家名称
@property (nonatomic, assign) BOOL selected;

@end
