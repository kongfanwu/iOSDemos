//
//  XMHCredentiaManageVenditionTableView.h
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 销售列表

#import "XMHBaseTableView.h"
#import "XMHCredentiaModel.h"
@class XMHCredentiaManageVenditionTableView;

NS_ASSUME_NONNULL_BEGIN

@protocol XMHCredentiaManageVenditionTableViewDelegate <NSObject>

@optional

/**
 订单状态切换回调
 */
- (void)didChangeOrderTypeTableView:(XMHCredentiaManageVenditionTableView *)tableview;

/**
 点击工具按钮回调
 
 @param type 类型
 @param model cell model
 */
- (void)didSelectToolActionTableView:(XMHCredentiaManageVenditionTableView *)tableview type:(XMHCredentiaItemViewType)type model:(id)model toolItemModel:(XMHCredentiaOrderStateItemModel *)toolItemModel;

/**
 点击cell

 @param tableView XMHCredentiaManageVenditionTableView
 @param model model
 */
- (void)tableView:(XMHCredentiaManageVenditionTableView *)tableView didSelectModel:(id)model;
@end

@interface XMHCredentiaManageVenditionTableView : XMHBaseTableView
/** <##> */
@property (nonatomic, strong) XMHCredentiaModel *credentiaModel;
/** <##> */
@property (nonatomic, strong) NSArray *dataArray;
/** id */
@property (nonatomic, weak) id <XMHCredentiaManageVenditionTableViewDelegate> adelegate;
@end

NS_ASSUME_NONNULL_END
