//
//  LolHomeBaseModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/26.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  首页列表模型

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LolHomeBaseModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, assign)NSInteger  count;
@property (nonatomic, assign)NSInteger  num;
@property (nonatomic, assign)NSInteger  pro_num;
@property (nonatomic, assign)NSInteger  state;
@end
