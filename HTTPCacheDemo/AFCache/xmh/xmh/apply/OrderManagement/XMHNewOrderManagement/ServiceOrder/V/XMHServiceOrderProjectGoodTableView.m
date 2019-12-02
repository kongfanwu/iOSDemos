//
//  XMHServiceOrderProjectGoodTableView.m
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHServiceOrderProjectGoodTableView.h"
#import "XMHServiceGoodsModel.h"
#import "XMHServiceProjectModel.h"
#import "XMHServiceOrderCell.h"
#import "XMHShoppingCartManager.h"
#import "UITableView+XMHEmptyData.h"
@interface XMHServiceOrderProjectGoodTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XMHServiceOrderProjectGoodTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 100;
        self.rowHeight = UITableViewAutomaticDimension;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return self;
}


#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewDisplayWithMsg:@"" ifNecessaryForRowCount:_modelArray.count];
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMHServiceProjectModel *model = _modelArray[indexPath.row];
    
    XMHServiceOrderCell *cell = [XMHServiceOrderCell createCellWithTable:tableView];
    cell.indexPath = indexPath;
    [cell configureWithModel:model];
    // 点击处方服务，处方服务下的选择数量+1
    __weak typeof(self) _self = self;
    [cell setDidChangeBlock:^(XMHNumberView * _Nonnull numberView) {
        __strong typeof(_self) self = _self;
        // 使用次数不能大于剩余次数
//        if (model.type == XMHServiceOrderTypeChuFang || model.type == XMHServiceOrderTypeProject || model.type == XMHServiceOrderTypeGoods) {
//            if (numberView.currentNumber > model.num) {
//                [MzzHud toastWithTitle:@"提示" message:@"购买次数不能大于剩余次数"];
//                numberView.currentNumber = model.selectCount;
//                return;
//            }
//        }
//        model.selectCount = numberView.currentNumber;
//        [tableView reloadData];
//
//        // 选择数量为0，从购物车中移除
//        if (model.selectCount == 0) {
//            [XMHShoppingCartManager.sharedInstance deleteModel:model];
//        } else {
//            [XMHShoppingCartManager.sharedInstance addModel:model];
//        }
        // 处方，项目，产品有最大购买限制. 储存卡，时间卡没有
        if (model.type == XMHServiceOrderTypeChuFang || model.type == XMHServiceOrderTypeProject || model.type == XMHServiceOrderTypeGoods) {
            if (numberView.currentNumber > model.num) {
                [XMHProgressHUD showOnlyText:@"库存不足"];
                --numberView.currentNumber;
                return;
            }
        }
        
        // 任选卡最大购买限制校验
        if (model.type == XMHServiceOrderTypeTiKaNumCar && self.shoppingCartAddModelBlcok) {
            if (!self.shoppingCartAddModelBlcok(model)) {
                [XMHProgressHUD showOnlyText:@"库存不足"];
                --numberView.currentNumber;
            }
        }
        
        // model 记录购买数量
        if ([model respondsToSelector:@selector(setSelectCount:)]) {
            [model setSelectCount:numberView.currentNumber];
        }
    }];
    
    [cell setDidAddToShopCartBlock:^{
        __strong typeof(_self) self = _self;
        // 使用次数不能大于剩余次数
//        if (model.type == XMHServiceOrderTypeChuFang || model.type == XMHServiceOrderTypeProject || model.type == XMHServiceOrderTypeGoods) {
//            // 最大购买数
//            NSInteger maxNum = [XMHShoppingCartManager.sharedInstance maxNumShoppingCartBaseModel:model];
//            // 限制最大购买
//            if (model.selectCount > maxNum) {
//                [XMHProgressHUD showOnlyText:@"库存不足"];
//                return;
//            }
//
//            // 减库存
//            model.numUpdate = model.numUpdate - 1;
//            [tableView reloadData];
//        }
        // 任选卡类校验库存
//        if (self.shoppingCartAddModelBlcok) {
//            if (self.shoppingCartAddModelBlcok(model)) {
//                [XMHShoppingCartManager.sharedInstance addModel:model];
//            } else {
//                [XMHProgressHUD showOnlyText:@"库存不足"];
//            }
//        } else {
//            [XMHShoppingCartManager.sharedInstance addModel:model];
//        }
        
        if (model.selectCount <= 0) {
            [XMHProgressHUD showOnlyText:@"请选择购买数量"];
            return;
        }
        
        // 任选卡类校验库存
        if (self.shoppingCartAddModelBlcok) {
            if (self.shoppingCartAddModelBlcok(model)) {
                [XMHShoppingCartManager.sharedInstance addModel:model];
            } else {
                [XMHProgressHUD showOnlyText:@"库存不足"];
            }
        } else {
            [XMHShoppingCartManager.sharedInstance addModel:model];
        }
    }];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return UIView.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
