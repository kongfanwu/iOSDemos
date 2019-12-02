//
//  BookWaitCell.h
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaiYuYueModel;
@interface BookWaitCell : UITableViewCell
@property (nonatomic, copy) void (^BookWaitCellBlock)(NSString *userID);
/**
 *更新数据

 @param model 模型
 */
- (void)updateBookWaitCellModel:(DaiYuYueModel *)model;
@end
