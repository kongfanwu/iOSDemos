//
//  LolHomeGuKeModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/21.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LolHomeGuKeModel : NSObject
//用户id
@property (nonatomic, assign)NSInteger user_id;
//预约服务人数
@property (nonatomic, assign)NSInteger num;
//预约项目数
@property (nonatomic, assign)NSInteger pro_num;
//是否达标
@property (nonatomic, copy)NSString * state;
//顾客姓名
@property (nonatomic, copy)NSString * name;
@end
