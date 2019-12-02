//
//  SerViceRightCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SerViceRightCell.h"

@implementation SerViceRightCell{
    SLAppo_Pro  *_modelSLAppo_Pro;
    SLPro       *_SLPromodel;
    Pro_List    *_Pro_Listmodel;
    SLProModel  *_SLProModelmodel;
    SLGood      *_SLGoodmodel;
    SLPro_List  *_SLPro_Listmodel;
    SLGoods_List *_SLGoods_Listmodel;
    TiCardType  _TiCardTypetype;
    NSInteger   _whice;
    NSInteger   _ID;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
//预约服务 项目
- (void)freshSerViceRightCellPro:(SLAppo_Pro *)model{
    _modelSLAppo_Pro = model;
    _lb1.text = model.pro_name;
    _lb2.text = [NSString stringWithFormat:@"剩余%ld次",(long)model.num];
    _lb3.text = model.price;
    _lb4.text = model.jis_name;
    _lb5.text = model.appo_time;
    if (model.numDisplay == 0) {
        _lb6.text = [NSString stringWithFormat:@"%@",@""];
        _btn1.hidden = YES;
    }else{
        _lb6.text = [NSString stringWithFormat:@"%ld",(long)model.numDisplay];
        _btn1.hidden = NO;
    }
    [_btn1 addTarget:self action:@selector(btn1SLAppo_ProEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLAppo_ProEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLAppo_ProEvent{
    if (_btnSerViceRightCellSLAppo_ProBlock) {
        _btnSerViceRightCellSLAppo_ProBlock(_modelSLAppo_Pro,1);
    }
}
- (void)btn2SLAppo_ProEvent{
    if (_btnSerViceRightCellSLAppo_ProBlock) {
        _btnSerViceRightCellSLAppo_ProBlock(_modelSLAppo_Pro,2);
    }
}
//预约服务
- (void)freshSerViceRightCellPres:(SLPro *)model{
    _SLPromodel = model;
    _lb1.text = model.pro_name;
    _lb2.text = [NSString stringWithFormat:@"剩余%ld次",(long)model.num];
    _lb3.text = model.price;
    _lb4.text = model.jis_name;
    _lb5.text = model.appo_time;
    if (model.numDisplay == 0) {
        _lb6.text = [NSString stringWithFormat:@"%@",@""];
        _btn1.hidden = YES;
    }else{
        _lb6.text = [NSString stringWithFormat:@"%ld",(long)model.numDisplay];
        _btn1.hidden = NO;
    }
    [_btn1 addTarget:self action:@selector(btn1SLProEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLProEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLProEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellSLProBlock) {
        _btnSerViceRightCellSLProBlock(_SLPromodel,1);
    }
}
- (void)btn2SLProEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellSLProBlock) {
        _btnSerViceRightCellSLProBlock(_SLPromodel,2);
    }
}

//处方服务
- (void)freshSerViceRightCellPro_List:(Pro_List *)model{
    _Pro_Listmodel = model;
    _lb1.text = model.pro_name;
    _lb2.text = [NSString stringWithFormat:@"剩余%ld次",(long)model.num - model.num1];
    _lb3.text = model.price;
    if (model.numDisplay == 0) {
        _lb6.text = [NSString stringWithFormat:@"%@",@""];
        _btn1.hidden = YES;
    }else{
        _lb6.text = [NSString stringWithFormat:@"%ld",(long)model.numDisplay];
        _btn1.hidden = NO;
    }
    [self hiddenMethod];
    [_btn1 addTarget:self action:@selector(btn1Pro_ListEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2Pro_ListEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1Pro_ListEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellPro_ListBlock) {
        _btnSerViceRightCellPro_ListBlock(_Pro_Listmodel,1);
    }
}
- (void)btn2Pro_ListEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellPro_ListBlock) {
        _btnSerViceRightCellPro_ListBlock(_Pro_Listmodel,2);
    }
}

//项目服务
- (void)freshSerViceRightCellSLProModel:(SLProModel *)model{
    _SLProModelmodel = model;
    _lb1.text = model.name;
    _lb9.text = @"成交单价：";
    _lb2.text = [NSString stringWithFormat:@"剩余%ld次",(long)model.num];
    _lb3.text = [NSString stringWithFormat:@"%ld",(long)model.price];
    if (model.numDisplay == 0) {
        _lb6.text = [NSString stringWithFormat:@"%@",@""];
        _btn1.hidden = YES;
    }else{
        _lb6.text = [NSString stringWithFormat:@"%ld",(long)model.numDisplay];
        _btn1.hidden = NO;
    }
    [self hiddenMethod];
    [_btn1 addTarget:self action:@selector(btn1SLProModelEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLProModelEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLProModelEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellSLProModelBlock) {
        _btnSerViceRightCellSLProModelBlock(_SLProModelmodel,1);
    }
}
- (void)btn2SLProModelEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellSLProModelBlock) {
        _btnSerViceRightCellSLProModelBlock(_SLProModelmodel,2);
    }
}

//产品服务
- (void)freshSerViceRightCellSLGood:(SLGood *)model{
    _SLGoodmodel = model;
    _lb1.text = model.name;
    _lb9.text = @"成交单价：";
    _lb2.text = [NSString stringWithFormat:@"剩余%ld次",(long)model.s_num];
    _lb3.text = [NSString stringWithFormat:@"%ld",(long)model.price];
    if (model.numDisplay == 0) {
        _lb6.text = [NSString stringWithFormat:@"%@",@""];
        _btn1.hidden = YES;
    }else{
        _lb6.text = [NSString stringWithFormat:@"%ld",(long)model.numDisplay];
        _btn1.hidden = NO;
    }
    [self hiddenMethod];
    [_btn1 addTarget:self action:@selector(btn1SLGoodEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLGoodEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLGoodEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellSLGoodBlock) {
        _btnSerViceRightCellSLGoodBlock(_SLGoodmodel,1);
    }
}
- (void)btn2SLGoodEvent{
    if ([_lb6.text isEqualToString:@"0"]) {
        _btn1.hidden = YES;
    }else{
        _btn1.hidden = NO;
    }
    if (_btnSerViceRightCellSLGoodBlock) {
        _btnSerViceRightCellSLGoodBlock(_SLGoodmodel,2);
    }
}
//提卡-项目
- (void)freshSerViceRightCellSLPro_List:(SLPro_List *)model Id:(NSInteger)ID Type:(TiCardType)type Whice:(NSInteger)whice{
    _SLPro_Listmodel = model;
    _TiCardTypetype = type;
    _whice = whice;
    _ID = ID;
    _lb1.text = model.name;
    _lb9.text = @"单价：";
    _lb2.text = [NSString stringWithFormat:@"时长%ld分钟",(long)model.shichang];
    _lb3.text = [NSString stringWithFormat:@"%.2f",model.price];
    _lb6.text = [NSString stringWithFormat:@"%ld",(long)model.numDisplay];
    [self hiddenMethod];
    [_btn1 addTarget:self action:@selector(btn1SLPro_ListEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLPro_ListEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLPro_ListEvent{
    if (_btnSerViceRightCellSLPro_ListdBlock) {
        _btnSerViceRightCellSLPro_ListdBlock(_ID,_SLPro_Listmodel,_TiCardTypetype,_whice,1);
    }
}
- (void)btn2SLPro_ListEvent{
    if (_btnSerViceRightCellSLPro_ListdBlock) {
        _btnSerViceRightCellSLPro_ListdBlock(_ID,_SLPro_Listmodel,_TiCardTypetype,_whice,2);
    }
}
//提卡-产品
- (void)freshSerViceRightCellSLGoods_List:(SLGoods_List *)model Id:(NSInteger)ID Type:(TiCardType)type Whice:(NSInteger)whice{
    _SLGoods_Listmodel = model;
    _TiCardTypetype = type;
    _whice = whice;
    _ID = ID;
    _lb1.text = model.name;
    _lb9.text = @"单价：";
    _lb2.text =@"";
    _lb3.text = [NSString stringWithFormat:@"%.2f",model.price];
    _lb6.text = [NSString stringWithFormat:@"%ld",(long)model.numDisplay];
    [self hiddenMethod];
    [_btn1 addTarget:self action:@selector(btn1SLGoods_ListEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(btn2SLGoods_ListEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn1SLGoods_ListEvent{
    if (_btnSerViceRightCellSLGoods_ListBlock) {
        _btnSerViceRightCellSLGoods_ListBlock(_ID,_SLGoods_Listmodel,_TiCardTypetype,_whice,1);
    }
}
- (void)btn2SLGoods_ListEvent{
    if (_btnSerViceRightCellSLGoods_ListBlock) {
        _btnSerViceRightCellSLGoods_ListBlock(_ID,_SLGoods_Listmodel,_TiCardTypetype,_whice,2);
    }
}
- (void)hiddenMethod{
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    _lb7.hidden = YES;
    _lb8.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
