//
//  SAFQListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SAFQModel;
@interface SAFQListModel : NSObject

@property (nonatomic, assign)NSInteger qiankuan;
@property (nonatomic, assign)NSInteger order_type;
@property (nonatomic, strong)NSArray <SAFQModel *>* list;
@property (nonatomic, strong)NSArray <SAFQModel *>* cart;
@end

@interface SAFQModel : NSObject
//未付清
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, strong)NSString * goods_code;
@property (nonatomic, assign)NSInteger numz;
@property (nonatomic, strong)NSArray * num;
@property (nonatomic, strong)NSString * amount;
@property (nonatomic, strong)NSString * amount_a;
@property (nonatomic, strong)NSString * yh_amount;
@property (nonatomic, strong)NSString * name;
@property (nonatomic, strong)NSString * type;
@property (nonatomic, assign)NSInteger  qk_amount;
@property (nonatomic, assign)NSInteger tk_amount;
@property (nonatomic, strong)NSString * code;
//代付款

@end
