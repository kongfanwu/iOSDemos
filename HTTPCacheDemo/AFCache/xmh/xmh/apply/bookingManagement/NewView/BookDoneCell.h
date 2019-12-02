//
//  BookDoneCell.h
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YiYuYueModel;
@interface BookDoneCell : UITableViewCell
@property (nonatomic, copy) void (^BookDoneCellBlock)(YiYuYueModel *model,NSInteger tag);
/**
 *更新数据
 
 @param model 模型
 */
- (void)updateBookDoneCellModel:(YiYuYueModel *)model;

- (void)updateCellParam:(NSDictionary *)param;
@end
