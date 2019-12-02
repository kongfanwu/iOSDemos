//
//  SaleGouWuCheCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SaleGouWuCheCell.h"

@implementation SaleGouWuCheCell
{
    SaleModel *_model;
    NSMutableDictionary *_dic;
    BOOL _isSale;
    NSInteger _flagNum;
    
    SAZhiHuanPorModel *_SAZhiHuanPorModelmodel;
    
    SADepositListModelSales *_SADepositListModelSales;
    
    SAAccountModel *_SAAccountModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)freshUserGouWuCheCell:(SAAccountModel *)model{
    _SAAccountModel = model;
    _lbTitle.text = [NSString stringWithFormat:@"用户充值：%@",model.inputPrice];
    _lbNum.text = [NSString stringWithFormat:@"%@",@(1)];
    _flagNum = 5;
}

- (void)freshSaleGouWuCheCell:(SaleModel *)model{
    _model = model;
    _lbTitle.text = model.name;
    _lbNum.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
    _flagNum = 1;
}

- (void)freshSaleServerGouWuCheCell:(NSMutableDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lbNum.text = [NSString stringWithFormat:@"%@",dic[@"num"]];
    _flagNum = 2;
}

- (void)freshFuWuDanGouWuCheCell:(NSMutableDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lbNum.text = [NSString stringWithFormat:@"%@",dic[@"numDisplay"]];
    _flagNum = 2;
}

- (void)freshSKXKGouWuCheCell:(NSMutableDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lbNum.text = dic[@"numDisplay"];
    _flagNum = 6;
}
- (void)freshYiGouZhiHuanProSaleGouWuCheCell:(SAZhiHuanPorModel *)model{
    _SAZhiHuanPorModelmodel = model;
    _lbTitle.text = model.name;
    _lbNum.text = [NSString stringWithFormat:@"%@",@(model.numDisPlay)];
    _flagNum = 3;
}

- (void)freshYiGouZhiHuanDingjinSaleGouWuCheCell:(SADepositListModelSales *)model{
    _SADepositListModelSales = model;
    _lbTitle.text = model.ordernum;
    _lbNum.text = [NSString stringWithFormat:@"%@",@(model.numDisPlay)];
    _flagNum = 4;
}

- (IBAction)reduceEvent:(UIButton *)sender {
    if (_flagNum == 1) {
        if (_btnSaleGouWuCheCellAddBlock) {
            _btnSaleGouWuCheCellAddBlock(_model,1);
        }
    }else if(_flagNum == 2){
        if (_btnSaleGouWuCheCellXiaoShouFuWuDanAddBlock) {
            _btnSaleGouWuCheCellXiaoShouFuWuDanAddBlock(_dic,1);
        }
    }else if (_flagNum == 3){
        if (_btnSaleYiGouZhiHuanProGouWuCheCellAddBlock) {
            _btnSaleYiGouZhiHuanProGouWuCheCellAddBlock(_SAZhiHuanPorModelmodel,1);
        }
    }else if (_flagNum == 4){
        if (_btnSaleYiGouZhiHuanDingJinGouWuCheCellAddBlock) {
            _btnSaleYiGouZhiHuanDingJinGouWuCheCellAddBlock(_SADepositListModelSales,1);
        }
    }else if (_flagNum == 5){
        if (_btnCustomerUserGouWuCheCellAddBlock) {
            _btnCustomerUserGouWuCheCellAddBlock(_SAAccountModel,1);
        }
    }else if (_flagNum == 6){
        if (_btnSKXKGouWuCheCellAddBlock) {
            _btnSKXKGouWuCheCellAddBlock(_dic,1);
        }
    }
}
- (IBAction)addEvent:(UIButton *)sender {
    if (_flagNum == 1) {
        if (_btnSaleGouWuCheCellAddBlock) {
            _btnSaleGouWuCheCellAddBlock(_model,2);
        }
    }else if(_flagNum == 2){
        if (_btnSaleGouWuCheCellXiaoShouFuWuDanAddBlock) {
            _btnSaleGouWuCheCellXiaoShouFuWuDanAddBlock(_dic,2);
        }
    }else if (_flagNum == 3){
        if (_btnSaleYiGouZhiHuanProGouWuCheCellAddBlock) {
            _btnSaleYiGouZhiHuanProGouWuCheCellAddBlock(_SAZhiHuanPorModelmodel,2);
        }
    }else if (_flagNum == 4){
        if (_btnSaleYiGouZhiHuanDingJinGouWuCheCellAddBlock) {
            _btnSaleYiGouZhiHuanDingJinGouWuCheCellAddBlock(_SADepositListModelSales,2);
        }
    }else if (_flagNum == 5){
        if (_btnCustomerUserGouWuCheCellAddBlock) {
            _btnCustomerUserGouWuCheCellAddBlock(_SAAccountModel,2);
        }
    }else if (_flagNum == 6){
        if (_btnSKXKGouWuCheCellAddBlock) {
            _btnSKXKGouWuCheCellAddBlock(_dic,2);
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
