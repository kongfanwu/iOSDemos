//
//  LolGuKeCalender.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  看某一个顾客时候的日历

#import <UIKit/UIKit.h>
@class LolGuKeStateModelList;
@interface LolGuKeCalender : UITableViewCell
@property (copy, nonatomic)void (^LolGuKeCalenderBlock)(LolGuKeStateModelList * model);
@property (copy, nonatomic)void (^LolGuKeCalenderDataChangeBlock)(NSString * selectDate);
- (void)setInID:(NSString *)inid date:(NSString *)date;
@end
