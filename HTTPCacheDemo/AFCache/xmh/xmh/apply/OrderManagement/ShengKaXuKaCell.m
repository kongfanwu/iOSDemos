//
//  ShengKaXuKaCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "ShengKaXuKaCell.h"

@implementation ShengKaXuKaCell{
    ShengKaXuKaRenXuanData *_ShengKaXuKaRenXuanDatamodel;
    ShengKaChuZhiList *_ShengKaChuZhiListmodel;
    ShengKaXuKaShiJianList *_ShengKaXuKaShiJianListmodel;
    
    SAZhiHuanPorModel *_sAZhiHuanPorModel;
    SKXKProOneceModel *_sKXKProOneceModelmodel;
    
    NSInteger fuckNum;
    NSInteger xiajibafenlei;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnShop.layer.borderWidth = 1;
    _btnShop.layer.cornerRadius = 15;
    _btnShop.layer.borderColor = [kBtn_Commen_Color CGColor];
    _textJinE.delegate = self;
    _lbTitle.userInteractionEnabled = YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (xiajibafenlei == 1) {
        if (textField.text && ![textField.text isEqualToString:@""]) {
            _sAZhiHuanPorModel.intPutPrice = _textJinE.text;
            _sAZhiHuanPorModel.totalPrice = _sAZhiHuanPorModel.intPutPrice;
        }else{
            NSString *tempprice = @"";
            tempprice = [NSString stringWithFormat:@"%@",@(_sAZhiHuanPorModel.numDisPlay * _sAZhiHuanPorModel.price)];
            _sAZhiHuanPorModel.totalPrice = tempprice;
            _sAZhiHuanPorModel.intPutPrice = @"";
        }
    }
}
- (IBAction)btn1Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 2:
        {
            _ShengKaXuKaRenXuanDatamodel.award_del = @"1";
        }
            break;
        case 3:
        {
            _ShengKaChuZhiListmodel.award_del = @"1";
        }
            break;
        case 4:
        {
            _ShengKaXuKaShiJianListmodel.award_del = @"2";
        }
            break;
        default:
            break;
    }
    _btn1.selected = YES;
    _btn2.selected = NO;
}

- (IBAction)btn2Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 2:
        {
            _ShengKaXuKaRenXuanDatamodel.award_del = @"2";
        }
            break;
        case 3:
        {
            _ShengKaChuZhiListmodel.award_del = @"2";
        }
            break;
        case 4:
        {
            _ShengKaXuKaShiJianListmodel.award_del = @"2";
        }
            break;
        default:
            break;
    }
    _btn1.selected = NO;
    _btn2.selected = YES;
}
- (IBAction)btn3Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 1:
        {
            _sKXKProOneceModelmodel.save_old = @"1";
        }
            break;
        case 2:
        {
            _ShengKaXuKaRenXuanDatamodel.award_del = @"1";
        }
            break;
        case 3:
        {
            _ShengKaChuZhiListmodel.save_old = @"1";
        }
            break;
        case 4:
        {
            _ShengKaXuKaShiJianListmodel.save_old = @"1";
        }
            break;
        default:
            break;
    }
}
- (IBAction)btn4Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 1:
        {
            _sKXKProOneceModelmodel.save_old = @"2";
        }
            break;
        case 2:
        {
            _ShengKaXuKaRenXuanDatamodel.award_del = @"2";
        }
            break;
        case 3:
        {
            _ShengKaChuZhiListmodel.save_old = @"2";
        }
            break;
        case 4:
        {
            _ShengKaXuKaShiJianListmodel.save_old = @"2";
        }
            break;
        default:
            break;
    }
}
- (IBAction)btn5Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 1:
        {
            if (_sKXKProOneceModelmodel.ShengKaXuKaProList.count == 0) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择项目"];
                return;
            }
            if (!_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _sKXKProOneceModelmodel.up_type = @"1";
            
            NSInteger totoprice = 0;
            for (ShengKaXuKaProDataList *tempmodel in _sKXKProOneceModelmodel.ShengKaXuKaProList) {
                if (tempmodel.selected) {
                    totoprice += tempmodel.price;
                }
            }
            NSInteger upPrice = [_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
            
            _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice - totoprice)];
            _textJinE.userInteractionEnabled = NO;
            
        }
            break;
        case 2:
        {
            if (!_ShengKaXuKaRenXuanDatamodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaXuKaRenXuanDatamodel.up_type = @"1";
            
            NSInteger upPrice = [_ShengKaXuKaRenXuanDatamodel.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
            
            _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice - _ShengKaXuKaRenXuanDatamodel.money)];
            _textJinE.userInteractionEnabled = NO;
        }
            break;
        case 3:
        {
            if (!_ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaChuZhiListmodel.up_type = @"1";
            
            NSInteger totoprice = [_ShengKaChuZhiListmodel.money integerValue];
            NSInteger upPrice = [_ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
            _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice - totoprice)];
            _textJinE.userInteractionEnabled = NO;
        }
            break;
        case 4:
        {
            if (!_ShengKaXuKaShiJianListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaXuKaShiJianListmodel.up_type = @"1";
            //时间卡的价格有待解决
            //            NSInteger totoprice = [_ShengKaXuKaShiJianListmodel.money integerValue];
            //            NSInteger upPrice = [_ShengKaXuKaShiJianListmodel.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
            //            _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice - totoprice)];
            _textJinE.userInteractionEnabled = NO;
        }
            break;
        default:
            break;
    }
    _btn5.selected = YES;
    _btn6.selected = NO;
    _btn7.selected = NO;
}
- (IBAction)btn6Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 1:
        {
            if (!_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _sKXKProOneceModelmodel.up_type = @"2";
            
            NSString *upPrice = _sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel.price;
            _textJinE.text = [NSString stringWithFormat:@"%@",upPrice];
            _textJinE.userInteractionEnabled = NO;
        }
            break;
        case 2:
        {
            if (!_ShengKaXuKaRenXuanDatamodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaXuKaRenXuanDatamodel.up_type = @"2";
            
            NSString *upPrice = _ShengKaXuKaRenXuanDatamodel.ShengKaXuKaShengKaMuBiaoListModel.price;
            _textJinE.text = [NSString stringWithFormat:@"%@",upPrice];
            _textJinE.userInteractionEnabled = NO;
        }
            break;
        case 3:
        {
            if (!_ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaChuZhiListmodel.up_type = @"2";
            
            NSString *upPrice = _ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel.price;
            _textJinE.text = [NSString stringWithFormat:@"%@",upPrice];
            _textJinE.userInteractionEnabled = NO;
        }
            break;
        case 4:
        {
            if (!_ShengKaXuKaShiJianListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaXuKaShiJianListmodel.up_type = @"2";
            
            NSString *upPrice = _ShengKaXuKaShiJianListmodel.ShengKaXuKaShengKaMuBiaoListModel.price;
            _textJinE.text = [NSString stringWithFormat:@"%@",upPrice];
            _textJinE.userInteractionEnabled = NO;
        }
            break;
        default:
            break;
    }
    _btn5.selected = NO;
    _btn6.selected = YES;
    _btn7.selected = NO;
}
- (IBAction)btn7Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 1:
        {
            if (!_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _sKXKProOneceModelmodel.up_type = @"3";
            _textJinE.userInteractionEnabled = YES;
        }
            break;
        case 2:
        {
            if (!_ShengKaXuKaRenXuanDatamodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaXuKaRenXuanDatamodel.up_type = @"3";
            _textJinE.userInteractionEnabled = YES;
        }
            break;
        case 3:
        {
            if (!_ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaChuZhiListmodel.up_type = @"3";
            _textJinE.userInteractionEnabled = YES;
        }
            break;
        case 4:
        {
            if (!_ShengKaXuKaShiJianListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
                [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
                return;
            }
            _ShengKaXuKaShiJianListmodel.up_type = @"3";
            _textJinE.userInteractionEnabled = YES;
        }
            break;
        default:
            break;
    }
    _btn5.selected = NO;
    _btn6.selected = NO;
    _btn7.selected = YES;
    
    _textJinE.text = @"";
    _textJinE.userInteractionEnabled = YES;
    [_textJinE becomeFirstResponder];
}
- (IBAction)btn8Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 1:
        {
            _sKXKProOneceModelmodel.to_type = @"1";
            _btn8.selected = YES;
            _btn9.selected = NO;
        }
            break;
        case 3:
        {
            _ShengKaChuZhiListmodel.to_type = @"1";
            _btn8.selected = YES;
            _btn9.selected = NO;
            if (_btnSKXKStore_cardSXEventBlock) {
                _btnSKXKStore_cardSXEventBlock(_ShengKaChuZhiListmodel,1);
            }
        }
            break;
        default:
            break;
    }
}
- (IBAction)btn9Event:(UIButton *)sender {
    
    switch (fuckNum) {
        case 1:
        {
            _sKXKProOneceModelmodel.to_type = @"2";
            _btn8.selected = NO;
            _btn9.selected = YES;
            
        }
            break;
        case 3:
        {
            _ShengKaChuZhiListmodel.to_type = @"2";
            _btn8.selected = NO;
            _btn9.selected = YES;
            if (_btnSKXKStore_cardSXEventBlock) {
                _btnSKXKStore_cardSXEventBlock(_ShengKaChuZhiListmodel,2);
            }
        }
            break;
        default:
            break;
    }
}
//点击标题时间卡
-(void)touchLbTitleTime:(UITapGestureRecognizer *)sender{
    _ShengKaXuKaShiJianListmodel.isShow = !_ShengKaXuKaShiJianListmodel.isShow;
    if (_btnMoreTimeEventBlock) {
        _btnMoreTimeEventBlock(_ShengKaXuKaShiJianListmodel);
    }
}
//时间卡
- (void)freshShengKaXuKashijianCell:(ShengKaXuKaShiJianList *)model{
    [self hiddenOther];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchLbTitleTime:)];
    //设置手指字数
    tap.numberOfTouchesRequired = 1;
    [_lbTitle addGestureRecognizer:tap];
    _lb18.hidden = YES;
    _lbTitle.text = model.name;
    _lb1.text = @"消耗金额：";
    _lb2.text = [NSString stringWithFormat:@"%@",@(model.money)];
    
    model.save_old = @"2";
    
    if (!model.to_type) {
        model.to_type = @"1";
    }
    if (!model.up_type) {
        model.up_type = @"2";
    }
    if (!model.award_del) {
        model.award_del = @"1";
    }
    fuckNum = 4;
    _ShengKaXuKaShiJianListmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb3.text = @"有效周期：";
        _lb4.text = [NSString stringWithFormat:@"%@天",@(model.expiry)];
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = NO;
        
        _btn7Top.constant = -20;
        _lb10Top.constant = 20;
        if ([model.award_del isEqualToString:@"1"]) {
            _btn1.selected = YES;
            _btn2.selected = NO;
        } else if([model.award_del isEqualToString:@"2"]){
            _btn1.selected = NO;
            _btn2.selected = YES;
        }
        
        if([model.up_type isEqualToString:@"3"]){
            _btn7.selected = YES;
        }
        if (model.ShengKaXuKaShengKaMuBiaoListModel.name) {
            _lb7.text = model.ShengKaXuKaShengKaMuBiaoListModel.name;
            _lb10.text = @"补交金额：";
        }else{
            _lb7.text = @"请选择升卡类型";
            _textJinE.userInteractionEnabled = NO;
        }
        if([model.up_type isEqualToString:@"2"]){
            _textJinE.userInteractionEnabled = NO;
        }
        [self showSomeView];
        
        _btn5.hidden = YES;
        _btn6.hidden = YES;
        _lb15.hidden = YES;
        _lb16.hidden = YES;
    }else{
        [self hiddenSomeview];
    }
    [_btnMore addTarget:self action:@selector(btnMoreTimeEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnMuBiao addTarget:self action:@selector(btnTiemMubiaoEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopCardTimeEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnMoreTimeEvent{
    _ShengKaXuKaShiJianListmodel.isShow = !_ShengKaXuKaShiJianListmodel.isShow;
    if (_btnMoreTimeEventBlock) {
        _btnMoreTimeEventBlock(_ShengKaXuKaShiJianListmodel);
    }
}
- (void)btnTiemMubiaoEvent{
    if (_btnTimemubiaoBlock) {
        _btnTimemubiaoBlock(_ShengKaXuKaShiJianListmodel);
    }
}
- (void)btnShopCardTimeEvent{
    
    if (!_ShengKaXuKaShiJianListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
        return;
    }
    if (!_textJinE.text||[_textJinE.text isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先填写金额"];
        return;
    }
    _ShengKaXuKaShiJianListmodel.inputPrice = _textJinE.text;
    NSString *ids = [NSString stringWithFormat:@"%@",@(_ShengKaXuKaShiJianListmodel.ID)];
    if (_btnShopShengKaXuKaTimeCellBlock) {
        _btnShopShengKaXuKaTimeCellBlock(ids,_ShengKaXuKaShiJianListmodel.ShengKaXuKaShengKaMuBiaoListModel.code,_ShengKaXuKaShiJianListmodel.award_del,_ShengKaXuKaShiJianListmodel.save_old,_ShengKaXuKaShiJianListmodel.to_type,_ShengKaXuKaShiJianListmodel.up_type,_ShengKaXuKaShiJianListmodel.inputPrice,_ShengKaXuKaShiJianListmodel.name,@"1",_ShengKaXuKaShiJianListmodel);
    }
}
//点击标题任选卡
-(void)touchLbTitleRenXuan:(UITapGestureRecognizer *)sender{
    _ShengKaXuKaRenXuanDatamodel.isShow = !_ShengKaXuKaRenXuanDatamodel.isShow;
    if (_btnMoreCardnumEventBlock) {
        _btnMoreCardnumEventBlock(_ShengKaXuKaRenXuanDatamodel);
    }
}
//任选卡
- (void)freshShengKaXuKaRenXuanCell:(ShengKaXuKaRenXuanData *)model{
    [self hiddenOther];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchLbTitleRenXuan:)];
    //设置手指字数
    tap.numberOfTouchesRequired = 1;
    [_lbTitle addGestureRecognizer:tap];
    _lb18.hidden = YES;
    _lbTitle.text = model.name?model.name:@"null";
    _lb1.text = @"剩余金额：";
    _lb2.text = [NSString stringWithFormat:@"%.2f",model.money];
    
    model.save_old = @"2";
    
    if (!model.to_type) {
        model.to_type = @"1";
    }
    if (!model.up_type) {
        model.up_type = @"2";
    }
    if (!model.award_del) {
        model.award_del = @"1";
    }
    
    _ShengKaXuKaRenXuanDatamodel = model;
    fuckNum = 2;
    
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb3.text = @"剩余次数：";
        _lb4.text = [NSString stringWithFormat:@"%ld",model.nums];
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = NO;
        
        if ([model.award_del isEqualToString:@"1"]) {
            _btn1.selected = YES;
            _btn2.selected = NO;
        } else if([model.award_del isEqualToString:@"2"]){
            _btn1.selected = NO;
            _btn2.selected = YES;
        }
        if ([model.up_type isEqualToString:@"1"]) {
            _btn5.selected = YES;
            _btn6.selected = NO;
            _btn7.selected = NO;
        } else if([model.up_type isEqualToString:@"2"]){
            _btn5.selected = NO;
            _btn6.selected = YES;
            _btn7.selected = NO;
        }else if([model.up_type isEqualToString:@"3"]){
            _btn5.selected = NO;
            _btn6.selected = NO;
            _btn7.selected = YES;
        }
        if (model.ShengKaXuKaShengKaMuBiaoListModel.name) {
            _lb7.text = model.ShengKaXuKaShengKaMuBiaoListModel.name;
            _lb10.text = @"补交金额：";
        }else{
            _lb7.text = @"请选择升卡类型";
            _textJinE.userInteractionEnabled = NO;
        }
        if ([model.up_type isEqualToString:@"1"]) {
            
            NSInteger upPrice = [model.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
            _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice - _ShengKaXuKaRenXuanDatamodel.money)];
            
        } else if([model.up_type isEqualToString:@"2"]){
            if (model.ShengKaXuKaShengKaMuBiaoListModel) {
                NSInteger upPrice = [model.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
                _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice)];
            }
            _textJinE.userInteractionEnabled = NO;
        }
        [self showSomeView];
    }else{
        [self hiddenSomeview];
    }
    [_btnMore addTarget:self action:@selector(btnMoreCardnumEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnMuBiao addTarget:self action:@selector(btnRenXuanubiaoEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopCardNumEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnMoreCardnumEvent{
    _ShengKaXuKaRenXuanDatamodel.isShow = !_ShengKaXuKaRenXuanDatamodel.isShow;
    if (_btnMoreCardnumEventBlock) {
        _btnMoreCardnumEventBlock(_ShengKaXuKaRenXuanDatamodel);
    }
}
- (void)btnRenXuanubiaoEvent{
    if (_btnRenXuanmubiaoBlock) {
        _btnRenXuanmubiaoBlock(_ShengKaXuKaRenXuanDatamodel);
    }
}
- (void)btnShopCardNumEvent{
    
    if (!_ShengKaXuKaRenXuanDatamodel.ShengKaXuKaShengKaMuBiaoListModel) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
        return;
    }
    if (!_textJinE.text||[_textJinE.text isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先填写金额"];
        return;
    }
    _ShengKaXuKaRenXuanDatamodel.inputPrice = _textJinE.text;
    NSString *ids = [NSString stringWithFormat:@"%@",@(_ShengKaXuKaRenXuanDatamodel.ID)];
    if (_btnShopShengKaXuKaCardNumCellBlock) {
        NSString *nums = [NSString stringWithFormat:@"%@",@(_ShengKaXuKaRenXuanDatamodel.nums)]; _btnShopShengKaXuKaCardNumCellBlock(ids,_ShengKaXuKaRenXuanDatamodel.ShengKaXuKaShengKaMuBiaoListModel.code,_ShengKaXuKaRenXuanDatamodel.award_del,_ShengKaXuKaRenXuanDatamodel.save_old,_ShengKaXuKaRenXuanDatamodel.to_type,_ShengKaXuKaRenXuanDatamodel.up_type,_ShengKaXuKaRenXuanDatamodel.inputPrice,_ShengKaXuKaRenXuanDatamodel.name,nums,_ShengKaXuKaRenXuanDatamodel);
    }
}
//项目疗程卡
- (void)freshShengKaXuKaProCell:(SKXKProOneceModel *)model{
    [self hiddenOther];
    _lbTitle.text = @"项目疗程：";
    _lb1.hidden = YES;
    _lb2.hidden = YES;
    _lb3.hidden = YES;
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    _btn1.hidden = YES;
    _btn2.hidden = YES;
    _lb11.hidden = YES;
    _lb12.hidden = YES;
    _lb6Top.constant = -70;
    _sKXKProOneceModelmodel = model;
    fuckNum = 1;
    
    if ([model.up_type isEqualToString:@"1"]) {
        _btn5.selected = YES;
        _btn6.selected = NO;
        _btn7.selected = NO;
    } else if([model.up_type isEqualToString:@"2"]){
        _btn5.selected = NO;
        _btn6.selected = YES;
        _btn7.selected = NO;
    }else if([model.up_type isEqualToString:@"3"]){
        _btn5.selected = NO;
        _btn6.selected = NO;
        _btn7.selected = YES;
    }
    NSInteger numXiangMu = 0;
    for (ShengKaXuKaProDataList *tempmodel in model.ShengKaXuKaProList) {
        if (tempmodel.selected) {
            numXiangMu++;
        }
    }
    if (numXiangMu) {
        _lb18.text = [NSString stringWithFormat:@"%ld个项目",numXiangMu];
    }else{
        _lb18.text = @"请选择项目";
        _textJinE.userInteractionEnabled = NO;
    }
    if (model.ShengKaXuKaShengKaMuBiaoListModel.name) {
        _lb7.text = model.ShengKaXuKaShengKaMuBiaoListModel.name;
    }else{
        _lb7.text = @"请选择升卡类型";
        _textJinE.userInteractionEnabled = NO;
    }
    if (numXiangMu && model.ShengKaXuKaShengKaMuBiaoListModel.name) {
        _lb10.text = @"补交金额：";
    }
    if ([model.up_type isEqualToString:@"2"]) {
        _textJinE.userInteractionEnabled = NO;
    }
    
    if ([_sKXKProOneceModelmodel.up_type isEqualToString:@"1"]) {
        if ((_sKXKProOneceModelmodel.ShengKaXuKaProList.count > 0) && (_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel)) {
            NSInteger totoprice = 0;
            for (ShengKaXuKaProDataList *tempmodel in _sKXKProOneceModelmodel.ShengKaXuKaProList) {
                if (tempmodel.selected) {
                    totoprice += tempmodel.price;
                }
            }
            NSInteger upPrice = [_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
            
            _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice - totoprice)];
        }
        
    } else if([_sKXKProOneceModelmodel.up_type isEqualToString:@"2"]){
        if (_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel) {
            NSInteger upPrice = [_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel.price integerValue];
            
            _textJinE.text = [NSString stringWithFormat:@"%@",@(upPrice)];
        }
    }
    [_btnShop addTarget:self action:@selector(btnShopproEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnShopproEvent{
    
    if (_sKXKProOneceModelmodel.ShengKaXuKaProList.count == 0) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择项目"];
        return;
    }
    if (!_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
        return;
    }
    if (!_textJinE.text||[_textJinE.text isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先填写金额"];
        return;
    }
    _sKXKProOneceModelmodel.inputPrice = _textJinE.text;
    if (_btnShopShengKaXuKaCellBlock)
    {
        NSString *ids =@"";
        for (ShengKaXuKaProDataList *tempmodel in _sKXKProOneceModelmodel.ShengKaXuKaProList) {
            if (tempmodel.selected) {
                ids = [ids stringByAppendingFormat:@"%@,",@(tempmodel.ID)];
            }
        }
        if (ids.length>=1) {
            ids = [ids substringToIndex:ids.length - 1];
        }
        _btnShopShengKaXuKaCellBlock(ids,_sKXKProOneceModelmodel.ShengKaXuKaShengKaMuBiaoListModel.code,_sKXKProOneceModelmodel.save_old,_sKXKProOneceModelmodel.to_type,_sKXKProOneceModelmodel.up_type,_sKXKProOneceModelmodel.inputPrice,_sKXKProOneceModelmodel);
    }
}
//点击标题储值卡
-(void)touchLbTitleChuZhi:(UITapGestureRecognizer *)sender{
    _ShengKaChuZhiListmodel.isShow = !_ShengKaChuZhiListmodel.isShow;
    if (_btnMoreStoreEventBlock) {
        _btnMoreStoreEventBlock(_ShengKaChuZhiListmodel);
    }
}
//储值卡
- (void)freshShengKaXuKaChuZhiCell:(ShengKaChuZhiList *)model{
    _lb18.hidden = YES;
    _lbTitle.text = model.name;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchLbTitleChuZhi:)];
    //设置手指字数
    tap.numberOfTouchesRequired = 1;
    [_lbTitle addGestureRecognizer:tap];
    _lb1.text = @"剩余金额：";
    _lb2.text = model.money;
    fuckNum = 3;
    if (!model.save_old) {
        model.save_old = @"2";
    }
    if (!model.to_type) {
        model.to_type = @"1";
    }
    if (!model.up_type) {
        model.up_type = @"2";
    }
    if (!model.award_del) {
        model.award_del = @"1";
    }
    _ShengKaChuZhiListmodel = model;
    
    if ([model.award_del isEqualToString:@"1"]) {
        _btn1.selected = YES;
        _btn2.selected = NO;
    } else if([model.award_del isEqualToString:@"2"]){
        _btn1.selected = NO;
        _btn2.selected = YES;
    }
    if ([model.to_type isEqualToString:@"1"]) {
        _btn8.selected = YES;
        _btn9.selected = NO;
    } else if([model.to_type isEqualToString:@"2"]){
        _btn8.selected = NO;
        _btn9.selected = YES;
    }
    if ([model.up_type isEqualToString:@"1"]) {
        _btn5.selected = YES;
        _btn6.selected = NO;
        _btn7.selected = NO;
    } else if([model.up_type isEqualToString:@"2"]){
        _btn5.selected = NO;
        _btn6.selected = YES;
        _btn7.selected = NO;
    }else if([model.up_type isEqualToString:@"3"]){
        _btn5.selected = NO;
        _btn6.selected = NO;
        _btn7.selected = YES;
    }
    if (model.isShow) {
        if ([model.to_type isEqualToString:@"1"]) {
            _lb5Top.constant = -20;
            _lb3.hidden = YES;
            _lb4.hidden = YES;
            _lb6Top.constant = 35;
            _lb9Top.constant = -15;
            
            _lb10.text = @"补交金额：";
            
            _btnReduce.hidden = YES;
            _lbnum.hidden = YES;
            _btnAdd.hidden = YES;
        } else if([model.to_type isEqualToString:@"2"]){
            _lb5Top.constant = -20;
            _lb3.hidden = YES;
            _lb4.hidden = YES;
            _lb6Top.constant = 35;
            _lb9Top.constant = -15;
            
            _lb10Top.constant = -40;
            _lb10.text = @"续卡金额：";
            _btnReduce.hidden = YES;
            _lbnum.hidden = YES;
            _btnAdd.hidden = YES;
            
            _lb9.hidden = YES;
            _btn5.hidden = YES;
            _btn6.hidden = YES;
            _btn7.hidden = YES;
            
            _lb15.hidden = YES;
            _lb16.hidden = YES;
            _lb17.hidden = YES;
            _lb6.hidden = YES;
            _lb7.hidden = YES;
            _btnMuBiao.hidden = YES;
        }
        
    }else{
        [self hiddenOther];
        [self hiddenSomeview];
    }
    if (model.ShengKaXuKaShengKaMuBiaoListModel.name) {
        _lb7.text = model.ShengKaXuKaShengKaMuBiaoListModel.name;
        _lb9Top.constant = 10;
    }else{
        _lb7.text = @"请选择升卡类型";
        _textJinE.userInteractionEnabled = NO;
        _lb9Top.constant = 10;
    }
    if ([model.up_type isEqualToString:@"1"]) {
        float totoprice = [model.money floatValue];
        float upPrice = [model.ShengKaXuKaShengKaMuBiaoListModel.price floatValue];
        _textJinE.text = [NSString stringWithFormat:@"%.2f",upPrice - totoprice];
    } else if([model.up_type isEqualToString:@"2"]){
        if (model.ShengKaXuKaShengKaMuBiaoListModel) {
            float upPrice = [model.ShengKaXuKaShengKaMuBiaoListModel.price floatValue];
            _textJinE.text = [NSString stringWithFormat:@"%.2f",upPrice];
        }
        _textJinE.userInteractionEnabled = YES;
    }
    
    [_btnMore addTarget:self action:@selector(btnMoreStoreEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnMuBiao addTarget:self action:@selector(btnStoremubiaoEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopStoreCardEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnMoreStoreEvent{
    _ShengKaChuZhiListmodel.isShow = !_ShengKaChuZhiListmodel.isShow;
    if (_btnMoreStoreEventBlock) {
        _btnMoreStoreEventBlock(_ShengKaChuZhiListmodel);
    }
}
- (void)btnStoremubiaoEvent{
    if (_btnStoremubiaoBlock) {
        _btnStoremubiaoBlock(_ShengKaChuZhiListmodel);
    }
}
- (void)btnShopStoreCardEvent{
    if ([_ShengKaChuZhiListmodel.to_type isEqualToString:@"1"]) {
        if (!_ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel) {
            [MzzHud toastWithTitle:@"温馨提示" message:@"请先选择升卡类型"];
            return;
        }
    }
    if (!_textJinE.text||[_textJinE.text isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请先填写金额"];
        return;
    }
    
    NSString *ids = [NSString stringWithFormat:@"%@",@(_ShengKaChuZhiListmodel.user_card_id)];
    
    _ShengKaChuZhiListmodel.inputPrice = _textJinE.text;
    if (_btnShopShengKaXuKaStoreCardCellBlock) {
        _btnShopShengKaXuKaStoreCardCellBlock(ids,_ShengKaChuZhiListmodel.ShengKaXuKaShengKaMuBiaoListModel.code,_ShengKaChuZhiListmodel.award_del,_ShengKaChuZhiListmodel.save_old,_ShengKaChuZhiListmodel.to_type,_ShengKaChuZhiListmodel.up_type,_ShengKaChuZhiListmodel.inputPrice,_ShengKaChuZhiListmodel.name,@"1",_ShengKaChuZhiListmodel);
    }
}
//已购置换-时间卡
- (void)freshYiGouZhiHuanTime:(SAZhiHuanPorModel *)model{
    [self hiddenOther];
    _lb18.hidden = YES;
    _lbTitle.text = model.name?model.name:@"null";
    _lb1.text = @"购买金额：";
    _lb2.text = [NSString stringWithFormat:@"%ld",model.price];
    _sAZhiHuanPorModel = model;
    xiajibafenlei = 1;
    [self hiddenSomeview];
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb3.text = @"消耗金额：";
        _lb4.text = [NSString stringWithFormat:@"%ld",model.xiaohao];
        _lb4.hidden = NO;
        _lb6.hidden = NO;
        _lb6.text = @"截止日期：";
        _lb7.text = model.end_time;
        _lb7.hidden = NO;
        _lb10.hidden = NO;
        _textJinE.hidden = NO;
        _lb10.text = @"回收金额：";
        _lb10Top.constant = - 50;
        
        _lbnum.text = [NSString stringWithFormat:@"%ld",model.numDisPlay];
        NSString *tempprice = @"";
        tempprice = [NSString stringWithFormat:@"%@",@(model.numDisPlay * model.price)];
        if (model.intPutPrice && ![model.intPutPrice isEqualToString:@""]) {
            _textJinE.text = model.intPutPrice;
            model.totalPrice = model.intPutPrice;
        } else {
            model.totalPrice = tempprice;
        }
        if (model.show_jz == 0) {
            _lb5.hidden = YES;
            _btn1.hidden = YES;
            _btn2.hidden = YES;
            _lb11.hidden = YES;
            _lb12.hidden = YES;
            self.toJzConstraint.constant = -20;
        }else{
            _lb5.hidden = NO;
            _btn1.hidden = NO;
            _btn2.hidden = NO;
            _lb11.hidden = NO;
            _lb12.hidden = NO;
            self.toJzConstraint.constant = 10;
        }
        
        _btnShop.hidden = NO;
        _btnReduce.hidden = NO;
        _lbnum.hidden = NO;
        _btnAdd.hidden = NO;
        _lb9Top.constant = 46;
    }
    [_btnMore addTarget:self action:@selector(btnMoreYiGouZhiHuanTimeEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnReduce addTarget:self action:@selector(btnReduceYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(btnAddYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)btnMoreYiGouZhiHuanTimeEvent{
    _sAZhiHuanPorModel.isShow = !_sAZhiHuanPorModel.isShow;
    if (_btnMoreYiGouZhiHuanTimeBlock) {
        _btnMoreYiGouZhiHuanTimeBlock(_sAZhiHuanPorModel);
    }
}
- (void)btnReduceYGZHEvent{
    if (_sAZhiHuanPorModel.numDisPlay > 0) {
        _sAZhiHuanPorModel.numDisPlay --;
    }
    if (_btnYGZHReduiceAddTimeBlock) {
        _btnYGZHReduiceAddTimeBlock(_sAZhiHuanPorModel,1);
    }
}
- (void)btnAddYGZHEvent{
    if (_sAZhiHuanPorModel.num > _sAZhiHuanPorModel.numDisPlay) {
        _sAZhiHuanPorModel.numDisPlay ++;
        if (_btnYGZHReduiceAddTimeBlock) {
            _btnYGZHReduiceAddTimeBlock(_sAZhiHuanPorModel,2);
        }
    }else{
        [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
    }
}
- (void)btnShopYGZHEvent{
    if (_btnShopYiGouZhiHuanTimeBlock) {
        _btnShopYiGouZhiHuanTimeBlock(_sAZhiHuanPorModel);
    }
}


//已购置换-票券
- (void)freshYiGouZhiHuanPiaoQuan:(SAZhiHuanPorModel *)model{
    [self hiddenOther];
    _lb18.hidden = YES;
    _lbTitle.text = model.name?model.name:@"null";
    _lb1.text = @"票券价格：";
    xiajibafenlei = 1;
    _lb2.text = [NSString stringWithFormat:@"%ld",model.price];
    _sAZhiHuanPorModel = model;
    [self hiddenSomeview];
    if (model.isShow) {
        _lb6.hidden = NO;
        _lb6.text = @"票券有效期：";
        _lb7.text = model.expiry;
        _lb7.hidden = NO;
        _lb10.hidden = NO;
        _textJinE.hidden = NO;
        _lb10.text = @"回收金额：";
        _btnAddTop.constant = - 5;
        _lb6Top.constant = -42;
        _lb10Top.constant = -50;
        _lbnum.text = [NSString stringWithFormat:@"%ld",model.numDisPlay];
        _btnShop.hidden = NO;
        _btnReduce.hidden = NO;
        _lbnum.hidden = NO;
        _btnAdd.hidden = NO;
        _lb9Top.constant = 46;
        
    }
    [_btnMore addTarget:self action:@selector(btnMoreYiGouZhiHuanTimeEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnReduce addTarget:self action:@selector(btnReduceYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(btnAddYGZHTitckertEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnAddYGZHTitckertEvent{
    if (_sAZhiHuanPorModel.nums > _sAZhiHuanPorModel.numDisPlay) {
        _sAZhiHuanPorModel.numDisPlay ++;
        if (_btnYGZHReduiceAddTimeBlock) {
            _btnYGZHReduiceAddTimeBlock(_sAZhiHuanPorModel,2);
        }
    }else{
        [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
    }
}

- (void)showSomeView{
    _btn1.hidden = NO;
    _btn2.hidden = NO;
    
    _btnMuBiao.hidden = NO;
    
    
    _lb11.hidden = NO;
    _lb12.hidden = NO;
    _lb15.hidden = NO;
    _lb16.hidden = NO;
    _lb17.hidden = NO;
    
    _lb9.hidden = NO;
    _lb10.hidden = NO;
    
    _btn5.hidden = NO;
    _btn6.hidden = NO;
    _btn7.hidden = NO;
    
    _textJinE.hidden = NO;
    _btnShop.hidden = NO;
}
- (void)hiddenSomeview{
    _lb3.hidden = YES;
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    _lb6.hidden = YES;
    _lb7.hidden = YES;
    
    _btn1.hidden = YES;
    _btn2.hidden = YES;
    
    _btnMuBiao.hidden = YES;
    
    
    _lb11.hidden = YES;
    _lb12.hidden = YES;
    _lb15.hidden = YES;
    _lb16.hidden = YES;
    _lb17.hidden = YES;
    
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    
    _btn5.hidden = YES;
    _btn6.hidden = YES;
    _btn7.hidden = YES;
    
    _textJinE.hidden = YES;
    _btnShop.hidden = YES;
}
- (void)hiddenOther{
    _lb19.hidden = YES;
    _btn8.hidden = YES;
    _btn9.hidden = YES;
    _lb20.hidden = YES;
    _lb21.hidden = YES;
    
    _btnReduce.hidden = YES;
    _lbnum.hidden = YES;
    _btnAdd.hidden = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
