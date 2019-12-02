//
//  XMHCredentiaManageVenditionTableView.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaManageVenditionTableView.h"
#import "XMHCredentiaManageVenditionStateView.h"
#import "XMHCredentiaManageVenditionSaleCell.h"
#import "XMHCredentiaManageVenditionServiceCell.h"
#import "XMHCredentiaSalesOrderMdoel.h"
#import "XMHCredentiaServiceOrderMdoel.h"

@interface XMHCredentiaManageVenditionTableView()

@end

@implementation XMHCredentiaManageVenditionTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyEnable = YES;
    }
    return self;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 安全处理
    if (indexPath.row >= _dataArray.count) {
        return UITableViewCell.new;
    }
    
    id model = _dataArray[indexPath.row];
    if ([model isKindOfClass:[XMHCredentiaSalesOrderMdoel class]]) {
        XMHCredentiaManageVenditionSaleCell *cell = [XMHCredentiaManageVenditionSaleCell createCellWithTable:tableView];
        [cell configureWithModel:model];
        __weak typeof(self) _self = self;
        cell.didSelectClickBlock = ^(XMHCredentiaManageVenditionSaleCell * _Nonnull cell, XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel) {
            __strong typeof(_self) self = _self;
            if ([self.adelegate respondsToSelector:@selector(didSelectToolActionTableView:type:model:toolItemModel:)]) {
                [self.adelegate didSelectToolActionTableView:self type:self.credentiaModel.type model:model toolItemModel:credentiaOrderStateItemModel];
            }
        };
        return cell;
    }
    else if ([model isKindOfClass:[XMHCredentiaServiceOrderMdoel class]]) {
        XMHCredentiaManageVenditionServiceCell *cell = [XMHCredentiaManageVenditionServiceCell createCellWithTable:tableView];
        [cell configureWithModel:model];
        __weak typeof(self) _self = self;
        cell.didSelectClickBlock = ^(XMHCredentiaManageVenditionServiceCell * _Nonnull cell, XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel) {
            __strong typeof(_self) self = _self;
            if ([self.adelegate respondsToSelector:@selector(didSelectToolActionTableView:type:model:toolItemModel:)]) {
                [self.adelegate didSelectToolActionTableView:self type:self.credentiaModel.type model:model toolItemModel:credentiaOrderStateItemModel];
            }
        };
        return cell;
    }
    return UITableViewCell.new;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    XMHCredentiaManageVenditionStateView *headerView = [[XMHCredentiaManageVenditionStateView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, headerHeight)];
    
    NSArray *stateArrray = [_credentiaModel currentOrderStateList];
    headerView.stateArrray = stateArrray;
    // 切换状态回调
    __weak typeof(self) _self = self;
    headerView.didSelectBlock = ^(XMHCredentiaManageVenditionStateView * _Nonnull view, XMHCredentiaOrderStateItemModel * _Nonnull credentiaOrderStateItemModel) {
        __strong typeof(_self) self = _self;
        if ([self.adelegate respondsToSelector:@selector(didChangeOrderTypeTableView:)]) {
            [self.adelegate didChangeOrderTypeTableView:self];
        }
    };
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArray[indexPath.row];
    if ([self.adelegate respondsToSelector:@selector(tableView:didSelectModel:)]) {
        [self.adelegate tableView:self didSelectModel:model];
    }
  
    
}

@end
