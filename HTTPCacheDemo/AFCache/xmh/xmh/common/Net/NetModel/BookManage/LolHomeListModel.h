//
//  LolHomeListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  首页统计列表model list

#import <Foundation/Foundation.h>
@class LolHomeModel;
@interface LolHomeListModel : NSObject
@property (strong ,nonatomic)NSMutableArray<LolHomeModel *> * list;
@property (copy, nonatomic)NSString * ptype;
@property (copy, nonatomic)NSString * total;
@end
