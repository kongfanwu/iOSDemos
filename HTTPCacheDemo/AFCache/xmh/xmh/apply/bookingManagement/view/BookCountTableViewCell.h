//
//  BookCountTableViewCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  预约管理首页 员工以上人员统计数据的cell 第一个cell

#import <UIKit/UIKit.h>
#import "HomePageHeadModel.h"
@interface BookCountTableViewCell : UITableViewCell
- (void)updateBookCountStaffTableViewCellHomePageHeadModel:(HomePageHeadModel *)model;
@end
