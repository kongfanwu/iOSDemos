//
//  XMHServiceOrderBaseContentVC.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHOrderContentSearchView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderBaseContentVC : UIViewController
/** 是否可编辑  NO 不可编辑 默认YES. 用于处理没有选择用户不显示情况*/
@property (nonatomic) BOOL edit;
/** 搜索 */
@property (nonatomic, strong) XMHOrderContentSearchView *searchView;
/** 服务类型 */
@property (nonatomic) XMHServiceOrderType type;
/** 服务类型label */
@property (nonatomic, strong) UILabel *serviceLabel;
/** <##> */
@property (nonatomic, strong) UITableView *tableView;
/** 搜索数据源 searchResultArray 搜索后集合*/
@property (nonatomic, strong) NSArray *searchDataArray, *searchResultArray;
/** 是否搜索状态 */
@property (nonatomic) BOOL isSearch;

/** 开始搜索 */
@property (nonatomic, copy) void (^startSearchBlock)();
/** 结束搜索 */
@property (nonatomic, copy) void (^endSearchBlock)();

/**
 将要显示
 */
- (void)viewWillAppear;

#pragma mark - Notification

- (void)shoppingCartUpdateNotification:(NSNotification *)not;
@end

NS_ASSUME_NONNULL_END
