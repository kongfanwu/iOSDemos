//
//  LiaoChengXiangMuModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiaoChengXiangMuInfo.h"
#import "YYModel.h"
@interface LiaoChengXiangMuModel : NSObject

@property(nonatomic, assign)long is_jz;
@property(nonatomic, assign)long uid;
@property(nonatomic, copy)NSString *pro_code;
@property(nonatomic, assign)long num1;
@property(nonatomic, copy)NSString *join_code;
@property(nonatomic, copy)NSString *ly_type;
@property(nonatomic, copy)NSString *yh_amount;
@property(nonatomic, copy)NSString *insert_time;
@property(nonatomic, copy)NSString *amount_a;
@property(nonatomic, assign)long num;
@property(nonatomic, assign)long fenqi_zt;
@property(nonatomic, assign)long numDisplay;
@property(nonatomic, assign)long numz;
@property(nonatomic, strong)LiaoChengXiangMuInfo *info;


@end
