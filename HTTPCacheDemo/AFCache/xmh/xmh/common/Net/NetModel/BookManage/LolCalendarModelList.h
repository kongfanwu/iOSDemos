//
//  LolCalendarModelList.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/9.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LolDayModel;
@interface LolCalendarModelList : NSObject
@property (strong ,nonatomic)NSMutableArray<LolDayModel *> * list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger serv_num;
@property (nonatomic, assign)NSInteger pro_num;
@property (nonatomic, assign)NSInteger standard;
@property (nonatomic, strong)NSString * probability;
@property (nonatomic, strong)NSString * date;
@property (nonatomic, strong)NSString * info;
@property (nonatomic, assign)BOOL isShowProbability;
@property (nonatomic, copy)NSString * selectDate;
@end
