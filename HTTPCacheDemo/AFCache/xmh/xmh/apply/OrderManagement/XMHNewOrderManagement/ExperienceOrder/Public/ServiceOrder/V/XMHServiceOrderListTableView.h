//
//  XMHServiceOrderListTableView.h
//  xmh
//
//  Created by KFW on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHBaseTableView.h"
@class XMHServiceOrderListTableView;

NS_ASSUME_NONNULL_BEGIN

@protocol XMHServiceOrderListTableViewDelegate <NSObject>

@optional

/**
 全部开始服务
 */
- (void)startServiceTableView:(XMHServiceOrderListTableView *)tableView;

/**
 添加技师
 */
- (void)addJiShiTableView:(XMHServiceOrderListTableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 删除项目或商品
 */
- (void)deleteProjectGoodsTableView:(XMHServiceOrderListTableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

@interface XMHServiceOrderListTableView : XMHBaseTableView
/** 已购商品列表 */
@property (nonatomic, strong) NSArray *modelArray;
/** <##> */
@property (nonatomic, weak) id <XMHServiceOrderListTableViewDelegate> adelegate;
/** 用户输入或自动选择的时长 */
@property (nonatomic, copy) NSString *shiChang;

/** 服务状态 默认 NO */
@property (nonatomic) BOOL isServiceState;
@end

NS_ASSUME_NONNULL_END
