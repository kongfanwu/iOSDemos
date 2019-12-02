//
//  BeautyShijiModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeautyShijiModel : NSObject
@property (nonatomic, assign) NSInteger cfjdrs;//处方接待人数
@property (nonatomic, assign) NSInteger cfxhje;//处方消耗金额
@property (nonatomic, assign) NSInteger cfzxcs;//处方执行次数
@property (nonatomic, assign) NSInteger cfzxxms;//处方执行项目数
@property (nonatomic, assign) NSInteger ghnwzx;//规划内未执行
@property (nonatomic, assign) NSInteger ghnzx;//规划内执行
@property (nonatomic, assign) NSInteger ghwzx;//规划外执行
@property (nonatomic, assign) NSInteger wddwzx;//未到店未执行
@end
