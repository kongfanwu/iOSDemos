//
//  BillTiYanFuwuRightCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BillTiYanFuwuRightCell.h"

@implementation BillTiYanFuwuRightCell{
    SLS_Pro *_SLS_ProModel;
    SLGoodModel *_SLGoodModelmodel;
    
    SLPro_ListM *_SLPro_ListMmodel;
    SLGoods_ListM *_SLGoods_ListMmodel;
    
    NSInteger _fuckNumber;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tf1.delegate = self;
    [_btnQuan addTarget:self action:@selector(btnquanEvent) forControlEvents:UIControlEventTouchUpInside];

}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (_fuckNumber) {
        case 1:
            {
                _SLS_ProModel.inputPrice = _tf1.text;
                _SLS_ProModel.n_price = _SLS_ProModel.inputPrice;
                
            }
            break;
        case 2:
        {
            _SLGoodModelmodel.inputPrice = _tf1.text;
        }
            break;
        case 3:
        {
            _SLPro_ListMmodel.inputPrice = _tf1.text;
        }
            break;
        case 4:
        {
            _SLGoods_ListMmodel.inputPrice = _tf1.text;
        }
            break;
        default:
            break;
    }
}
//项目
- (void)freshBillTiYanFuwuRightCell1:(SLS_Pro *)model{
    _fuckNumber = 1;
    _lb1.text = model.name;
    _lb2.text = @"零售价：";
    _lb3.text = @"会员价：";
    _lb4.text = @"成交价格：";
    _btnShopAdd.layer.borderWidth = 1;
    _btnShopAdd.layer.cornerRadius = 15;
    _btnShopAdd.layer.borderColor = [kBtn_Commen_Color CGColor];
    _lb5.text = model.r_price;
    _lb6.text = model.vip_price;
    _lb7.text = [NSString stringWithFormat:@"%ld",model.num];
    _SLS_ProModel = model;
    if (_SLS_ProModel.sellProModel) {
        _lb12.text = _SLS_ProModel.sellProModel.name;
        _SLS_ProModel.n_price = [NSString stringWithFormat:@"%.2f",[_SLS_ProModel.r_price floatValue]*(_SLS_ProModel.num - 1)];
        _SLS_ProModel.diyongStr =_SLS_ProModel.sellProModel.name;
    }else{
        _SLS_ProModel.n_price = _SLS_ProModel.r_price;

        _SLS_ProModel.diyongStr =@"";
    }
    _tf1.text = _SLS_ProModel.r_price;
    _SLS_ProModel.inputPrice = [NSString stringWithFormat:@"%@",_tf1.text];

    [_btn1 addTarget:self action:@selector(btn1SLS_ProEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLS_ProEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShopAdd addTarget:self action:@selector(btnShopAddAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnShopAddAction{
    if (_btnShopGDKDBlock) {
        _btnShopGDKDBlock(_SLS_ProModel);
    }
}
- (void)btn1SLS_ProEvent{
     if (_SLS_ProModel.num > 0) {
         _SLS_ProModel.num --;
     }
    if (_SLS_ProModel.sellProModel) {
        _SLS_ProModel.n_price = [NSString stringWithFormat:@"%.2f",[_SLS_ProModel.r_price floatValue]*(_SLS_ProModel.num - 1)];
    }else{
        _SLS_ProModel.n_price = _SLS_ProModel.r_price;
        _tf1.text = _SLS_ProModel.r_price;
    }
    _SLS_ProModel.inputPrice = [NSString stringWithFormat:@"%@",_tf1.text];
    if (_btnBillTiYanFuwuRightCellSLS_ProBlock) {
        _btnBillTiYanFuwuRightCellSLS_ProBlock(_SLS_ProModel,1);
    }
}
- (void)btn2SLS_ProEvent{
    _SLS_ProModel.num ++;

    if (_SLS_ProModel.sellProModel) {
        _SLS_ProModel.n_price = [NSString stringWithFormat:@"%.2f",[_SLS_ProModel.r_price floatValue]*(_SLS_ProModel.num - 1)];
    }else{
        _SLS_ProModel.n_price = _SLS_ProModel.r_price;
        _tf1.text = _SLS_ProModel.r_price;
    }
    _SLS_ProModel.inputPrice = [NSString stringWithFormat:@"%@",_tf1.text];
    if (_btnBillTiYanFuwuRightCellSLS_ProBlock) {
        _btnBillTiYanFuwuRightCellSLS_ProBlock(_SLS_ProModel,2);
    }
}
//产品
- (void)freshBillTiYanFuwuRightCell2:(SLGoodModel *)model{
    _fuckNumber = 2;
    _lb1.text = model.name;
    _lb2.text = @"零售价：";
    _lb3.text = @"会员价：";
    _lb4.text = @"成交价格：";
    _SLGoodModelmodel = model;
    _lb5.text = model.r_price;
    _lb6.text = model.vip_price;
    _tf1.text = model.inputPrice;
    _lb7.text = [NSString stringWithFormat:@"%ld",model.num];
    _btnShopAdd.hidden = YES;
    //抵用券隐藏
    _lb12.hidden = YES;
    _lbTitle12.hidden = YES;
    _btnQuan.hidden = YES;
    _toTopConstraint.constant = 10;

    if (model.staicketModel) {
        _lb12.text = model.staicketModel.name;
    }
    [_btn1 addTarget:self action:@selector(btn1SLGoodModelEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLGoodModelEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLGoodModelEvent{
    if (_btnBillTiYanFuwuRightCellSLGoodModelBlock) {
        _btnBillTiYanFuwuRightCellSLGoodModelBlock(_SLGoodModelmodel,1);
    }
}
- (void)btn2SLGoodModelEvent{
    if (_btnBillTiYanFuwuRightCellSLGoodModelBlock) {
        _SLGoodModelmodel.inputPrice = _tf1.text;
        _btnBillTiYanFuwuRightCellSLGoodModelBlock(_SLGoodModelmodel,2);
    }
}
//体验-项目
- (void)freshBillTiYanFuwuRightCell3:(SLPro_ListM *)model{
    _fuckNumber = 3;
    _lb1.text = model.name;
    _lb2.text = @"零售价：";
    _lb3.text = [NSString stringWithFormat:@"共%ld次",model.num];
    _lb4.text = @"成交价格：";
    _lb5.text = model.price;
    _SLPro_ListMmodel = model;
    _tf1.text = model.inputPrice;
    _lb7.text = [NSString stringWithFormat:@"%ld",model.numDisplay];
    //抵用券隐藏
    _lb12.hidden = YES;
    _lbTitle12.hidden = YES;
    _btnQuan.hidden = YES;
    _toTopConstraint.constant = 10;
    _btnShopAdd.hidden = YES;

    if (model.staicketModel) {
        _lb12.text = model.staicketModel.name;
    }
    [_btn1 addTarget:self action:@selector(btn1SLPro_ListMEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLPro_ListMEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLPro_ListMEvent{
    if (_btnBillTiYanFuwuRightCellSLPro_ListMBlock) {
        _btnBillTiYanFuwuRightCellSLPro_ListMBlock(_SLPro_ListMmodel,1);
    }
}
- (void)btn2SLPro_ListMEvent{
    if (_btnBillTiYanFuwuRightCellSLPro_ListMBlock) {
        _SLPro_ListMmodel.inputPrice = _tf1.text;
        _btnBillTiYanFuwuRightCellSLPro_ListMBlock(_SLPro_ListMmodel,2);
    }
}
//体验-产品
- (void)freshBillTiYanFuwuRightCell4:(SLGoods_ListM *)model{
    _fuckNumber = 4;
    _lb1.text = model.name;
    _lb2.text = @"零售价：";
    _lb3.text = [NSString stringWithFormat:@"共%ld次",model.num];
    _lb4.text = @"成交价格：";
    _lb5.text = model.price;
    _SLGoods_ListMmodel = model;
    _tf1.text = model.inputPrice;
    _lb7.text = [NSString stringWithFormat:@"%ld",model.numDisplay];
    //抵用券隐藏
    _lb12.hidden = YES;
    _lbTitle12.hidden = YES;
    _btnQuan.hidden = YES;
    _toTopConstraint.constant = 10;
    _btnShopAdd.hidden = YES;

    if (model.staicketModel) {
        _lb12.text = model.staicketModel.name;
    }
    [_btn1 addTarget:self action:@selector(btn1SLGoods_ListMEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLGoods_ListMEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLGoods_ListMEvent{
    if (_btnBillTiYanFuwuRightCellSLGoods_ListMBlock) {
        _btnBillTiYanFuwuRightCellSLGoods_ListMBlock(_SLGoods_ListMmodel,1);
    }
}
- (void)btn2SLGoods_ListMEvent{
    if (_btnBillTiYanFuwuRightCellSLGoods_ListMBlock) {
        _SLGoods_ListMmodel.inputPrice = _tf1.text;
        _btnBillTiYanFuwuRightCellSLGoods_ListMBlock(_SLGoods_ListMmodel,2);
    }
}
- (void)btnquanEvent{
    if (_btnQuanGDKDBlock) {
        _btnQuanGDKDBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
