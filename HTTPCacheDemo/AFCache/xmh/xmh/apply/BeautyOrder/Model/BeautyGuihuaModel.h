//
//  BeautyGuihuaModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeautyGuihuaModel : NSObject
@property (nonatomic, assign) NSInteger ghzcfs;//规划总处方数
@property (nonatomic, assign) NSInteger ghzcs;//规划总次数
@property (nonatomic, assign) double ghzje;//规划总金额
@property (nonatomic, assign) NSInteger ghzxms;//规划总项目数
@property (nonatomic, assign) NSInteger wkcfrs;//未开处方人数
@property (nonatomic, assign) NSInteger ykcfrs;//已开处方人数
@end
