//
//  XMHReportFilterCell.h
//  xmh
//
//  Created by ald_ios on 2019/7/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTreeItem,XMHReportFilterOrganizeModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHReportFilterCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andTreeItem:(MYTreeItem *)item;
- (void)updateItem;
- (void)updateCellModel:(XMHReportFilterOrganizeModel *)model;
@property (nonatomic, copy)   void (^checkButtonClickBlock)(MYTreeItem *item);
@property (nonatomic, assign) BOOL isShowArrow;
@property (nonatomic, assign) BOOL isShowCheck;
@property (nonatomic, assign) BOOL isShowLevelColor;
@end

NS_ASSUME_NONNULL_END
