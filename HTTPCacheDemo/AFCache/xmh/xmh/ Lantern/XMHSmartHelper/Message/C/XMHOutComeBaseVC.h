//
//  XMHOutComeBaseVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "XMHOutComeProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHOutComeBaseVC : BaseCommonViewController<XMHOutComeProtocol>

@property(nonatomic, strong) UITableView *tableView;

/**
 * @brief 子类重写cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView subCellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * @brief 子类重写didselected
 */
- (void)tableView:(UITableView *)tableView subDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * @brief 子类重写numberOfRows
 */
- (NSInteger)tableView:(UITableView *)tableView subNumberOfRowsInSection:(NSInteger)section;

/**
 * @brief 子类重写heightForRow
 */
- (CGFloat)tableView:(UITableView *)tableView subHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * @brief 子类重写viewForHeader
 */
- (UIView *)tableView:(UITableView *)tableView subViewForHeaderInSection:(NSInteger)section;

/**
 * @brief 子类重写heightForHeader
 */
- (CGFloat)tableView:(UITableView *)tableView subHeightForHeaderInSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
