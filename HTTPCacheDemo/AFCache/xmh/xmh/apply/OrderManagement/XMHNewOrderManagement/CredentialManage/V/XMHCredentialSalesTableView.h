//
//  XMHCredentialSalesTableView.h
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 销售业绩 配合消费tableview

#import "XMHBaseTableView.h"
@class XMHCredentialSalesTableView;
NS_ASSUME_NONNULL_BEGIN
@protocol XMHCredentialSalesTableViewDelegate <NSObject>

@optional

/**
 点击cell
 
 @param tableView XMHCredentiaManageVenditionTableView
 @param model model
 */
- (void)tableView:(XMHCredentialSalesTableView *)tableView didSelectModel:(id)model;
@end

@interface XMHCredentialSalesTableView : XMHBaseTableView
/** <##> */
@property (nonatomic, strong) NSArray *dataArray;
/** id */
@property (nonatomic, weak) id <XMHCredentialSalesTableViewDelegate> adelegate;

@end

NS_ASSUME_NONNULL_END
