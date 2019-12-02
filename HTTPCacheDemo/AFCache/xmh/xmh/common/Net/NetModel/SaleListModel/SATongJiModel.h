//
//  SATongJiModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SATongJiModel : NSObject

@property (nonatomic ,copy)NSString * count_a;//销售业绩
@property (nonatomic ,copy)NSString * count_d;// 销售单数
@property (nonatomic ,copy)NSString * count_pro;//销售项目数
@property (nonatomic ,copy)NSString * count_r;//销售人数
@property (nonatomic ,copy)NSString * count_h;//回款单数
@property (nonatomic ,copy)NSString * count_w;//未还清金额
@property (nonatomic ,copy)NSString * count_t;//退款金额
@property (nonatomic ,copy)NSString * count_ph;//配合消费
@end
