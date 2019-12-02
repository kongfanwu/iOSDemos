//
//  HomePageHeadModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/8.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  预约管理顶部统计数据 model

#import <Foundation/Foundation.h>

@interface HomePageHeadModel : NSObject
//实行预约
@property (nonatomic, assign)NSInteger zxyy;
//到店率
@property (nonatomic, assign)CGFloat ddl;
//实际接待
@property (nonatomic, assign)NSInteger sjjd;
//未按时到店
@property (nonatomic, assign)NSInteger wasdd;
//规划外到店
@property (nonatomic, assign)NSInteger ghwdd;
//修改预约
@property (nonatomic, assign)NSInteger xgyy;
//待预约
@property (nonatomic, assign)NSInteger dyy;
//已预约
@property (nonatomic, assign)NSInteger yyy;


@end
