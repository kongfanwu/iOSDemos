//
//  BookStaffCalenderCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXCalendarView.h"
@class LolCalendarModelList,LolDayModel;
@interface BookStaffCalenderCell : UITableViewCell
@property (nonatomic, strong)LXCalendarView * calender ;
- (void)updateBookStaffCalenderCellCalendarModel:(LolCalendarModelList *)model;
@end
