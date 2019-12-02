//
//  SaleGouWuCheCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASaleListModel.h"
#import "SAZhiHuanPorListModel.h"
#import "SADepositListModel.h"
#import "SAAccountModel.h"
@interface SaleGouWuCheCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnReduce;
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;


- (void)freshUserGouWuCheCell:(SAAccountModel *)model;

- (void)freshSaleGouWuCheCell:(SaleModel *)model;
//销售服务单
- (void)freshSaleServerGouWuCheCell:(NSMutableDictionary *)dic;

- (void)freshFuWuDanGouWuCheCell:(NSMutableDictionary *)dic;

- (void)freshSKXKGouWuCheCell:(NSMutableDictionary *)dic;

@property (nonatomic, copy) void (^btnSaleGouWuCheCellXiaoShouFuWuDanAddBlock)(NSMutableDictionary *dic,NSInteger addflag);

@property (nonatomic, copy) void (^btnSaleGouWuCheCellAddBlock)(SaleModel *BlockModel,NSInteger addflag);

- (void)freshYiGouZhiHuanProSaleGouWuCheCell:(SAZhiHuanPorModel *)model;

- (void)freshYiGouZhiHuanDingjinSaleGouWuCheCell:(SADepositListModelSales *)model;

@property (nonatomic, copy) void (^btnSaleYiGouZhiHuanProGouWuCheCellAddBlock)(SAZhiHuanPorModel *BlockModel,NSInteger addflag);

@property (nonatomic, copy) void (^btnSaleYiGouZhiHuanDingJinGouWuCheCellAddBlock)(SADepositListModelSales *BlockModel,NSInteger addflag);

@property (nonatomic, copy) void (^btnCustomerUserGouWuCheCellAddBlock)(SAAccountModel *BlockModel,NSInteger addflag);

@property (nonatomic, copy) void (^btnSKXKGouWuCheCellAddBlock)(NSMutableDictionary *BlockDic,NSInteger addflag);

@end
