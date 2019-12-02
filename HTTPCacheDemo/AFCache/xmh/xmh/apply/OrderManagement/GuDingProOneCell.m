//
//  GuDingProOneCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/21.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "GuDingProOneCell.h"

@implementation GuDingProOneCell{
    SaleModel *_SaleModelmodel;
    
    SAZhiHuanPorModel *_sAZhiHuanPorModel;
    
    SADepositListModelSales *_sADepositListModelSales;
    
    NSInteger xiabifenlei;
    
    SAAccountModel *_SAAccountModelmodel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnShop.layer.borderWidth = 1;
    _btnShop.layer.cornerRadius = 15;
    _btnShop.layer.borderColor = [kBtn_Commen_Color CGColor];
    
    _btnQuanBu.layer.borderWidth = 1;
    _btnQuanBu.layer.cornerRadius = 15;
    _btnQuanBu.layer.borderColor = [kBackgroundColor CGColor];
    
    [_btnMore addTarget:self action:@selector(btnMoreGuDingEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnReduce addTarget:self action:@selector(btnReduceGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(btnAddGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnQuanBu addTarget:self action:@selector(btnQuanBuEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnCishu addTarget:self action:@selector(btncishuEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnZhekou addTarget:self action:@selector(btnzhekouProEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnQuan addTarget:self action:@selector(btnquanEvent) forControlEvents:UIControlEventTouchUpInside];
    
    _textJiaGe.delegate = self;
    _lbTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchLbTitle:)];
    //设置手指字数
    tap.numberOfTouchesRequired = 1;
    [_lbTitle addGestureRecognizer:tap];
}
//点击标题手势
-(void)touchLbTitle:(UITapGestureRecognizer *)sender{
    _SaleModelmodel.isShow = !_SaleModelmodel.isShow;
    if (_btnMoreGuDingBlock) {
        _btnMoreGuDingBlock(_SaleModelmodel);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (xiabifenlei == 10) {
        if (textField.text && ![textField.text isEqualToString:@""]) {
            _SAAccountModelmodel.inputPrice = _textJiaGe.text;
        }else{
            _SAAccountModelmodel.inputPrice = @"";
        }
        
    } else {
        if (textField.text&&textField.text.length>0&&(![textField.text isEqualToString:@""])) {
            _SaleModelmodel.inputPrice = _textJiaGe.text;
            _SaleModelmodel.totalPrice = _SaleModelmodel.inputPrice;
        }else{
            _SaleModelmodel.inputPrice = @"";
            _SaleModelmodel.totalPrice = [NSString stringWithFormat:@"%@",@(_SaleModelmodel.addnum * [_SaleModelmodel.price_list.pro_11.price integerValue])];
        }
    }
}
//项目疗程
- (void)freshGuDingProOneCell:(SaleModel *)model{
    _lbTitle.text = model.name;
    _lb1.text = @"单次时长：";
    _lb2.text = [NSString stringWithFormat:@"%@分钟",@(model.shichang)];
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = NO;
        _lb8.hidden = NO;
        
        _lb3.text = @"零售价：";
        _lb5.text = @"会员价：";
        _lb7.text = @"疗程次数：";
        
        NSArray *arrNum = [model.price_list.pro_21.num componentsSeparatedByString:@","];
        NSArray *arrLingShou = [model.price_list.pro_21.price componentsSeparatedByString:@","];
        NSArray *arrHuiYuan = [model.price_list.pro_22.price componentsSeparatedByString:@","];
        
        if (model.ciShu) {
            _lb8.text = model.ciShu;
            for (NSInteger i=0; i<arrNum.count; i++) {
                NSString *tmpCiShu = arrNum[i];
                if ([model.ciShu isEqualToString:tmpCiShu]) {
                    if (i<arrLingShou.count) {
                        _lb4.text = arrLingShou[i];
                    }
                    if (i<arrHuiYuan.count) {
                        _lb6.text = arrHuiYuan[i];
                    }
                    break;
                }
            }
        }else{
            if (arrNum.count > 0) {
                _lb8.text = arrNum[0];
                model.ciShu = _lb8.text;
            }
            if (arrLingShou.count > 0) {
                _lb4.text = arrLingShou[0];//疗程成交价.
            }
            if (arrHuiYuan.count > 0) {
                _lb6.text = arrHuiYuan[0];
            }
        }
        if (model.sastoreCardModel) {
            if (model.sastoreCardModel.selected) {
                _lb10.text = model.sastoreCardModel.name;
                _SaleModelmodel.huiyuanName = model.sastoreCardModel.name;
            }else{
                _lb10.text = @"请选择优惠卡";
                _SaleModelmodel.huiyuanName = @"";
            }
        }
        if (model.staicketModel) {
            if (model.staicketModel.selected) {
                _lb12.text = model.staicketModel.name;
                _SaleModelmodel.diyongName = model.staicketModel.name;
            }else{
                _lb12.text = @"请选择抵用券";
                _SaleModelmodel.diyongName = @"";
            }
        }
        float totalprice = 0;
        if (model.sastoreCardModel) {
            if (model.sastoreCardModel.selected) {
                totalprice = model.addnum *[model.sastoreCardModel.price floatValue];
            }else{
                totalprice = model.addnum *[_lb4.text floatValue];
            }
        }else{
            totalprice = model.addnum *[_lb4.text floatValue];
        }
        if (model.staicketModel.type ==1) {
            if (model.staicketModel) {
                if (model.staicketModel.selected) {
                    totalprice = totalprice - [model.staicketModel.money floatValue];
                    if (totalprice<0) {
                        totalprice = 0;
                    }
                }
            }
        }else if (model.staicketModel.type == 3){
            if (model.staicketModel) {
                 if (model.staicketModel.selected) {
                     if (totalprice >= [model.staicketModel.fulfill floatValue]) {
                         totalprice = totalprice - [model.staicketModel.price floatValue];
                         if (totalprice<0) {
                             totalprice = 0;
                         }
                     }
                 }
                
            }
        }else if (model.staicketModel.type == 4){
            if (model.staicketModel) {
                if (model.staicketModel.selected) {
//                    if (totalprice >= [model.staicketModel.discount floatValue]) {
                        /** lol 20190215 */
                        CGFloat tempDi = 0.0f; /** 抵用券的钱 */
                        tempDi = totalprice * (1 - model.staicketModel.discount.floatValue/10);
                        if (model.staicketModel.fulfill.floatValue != 0) {
                            if (tempDi >= model.staicketModel.fulfill.floatValue) {
                                tempDi = model.staicketModel.fulfill.floatValue;
                            }
                        }
                        totalprice = totalprice - tempDi;
                        if (totalprice<0) {
                            totalprice = 0;
                        }
//                    }
                }
                
            }
        }
        _lb14.text = [NSString stringWithFormat:@"%.2f",totalprice];
        model.lingshouMoney = _lb4.text;
        model.totalPrice = [NSString stringWithFormat:@"%@",@(totalprice)];
        
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
        _lb9.hidden = NO;
        _lb10.hidden = NO;
        _lb11.hidden = NO;
        _lb12.hidden = NO;
        _lb13.hidden = NO;
        _lb14.hidden = NO;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = NO;
        _btnZhekou.hidden = NO;
        _btnQuan.hidden = NO;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        _lb3.hidden = YES;
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = YES;
        _lb15.hidden = YES;
        _btnAdd.hidden = YES;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = YES;
    }
}
- (void)btnQuanBuEvent{
    _sAZhiHuanPorModel.numDisPlay = _sAZhiHuanPorModel.nums;
    if (_btnQauanBuYiGouZhiHuanBlock) {
        _btnQauanBuYiGouZhiHuanBlock(_sAZhiHuanPorModel);
    }
}
- (void)btnMoreGuDingEvent{
    _SaleModelmodel.isShow = !_SaleModelmodel.isShow;
    if (_btnMoreGuDingBlock) {
        _btnMoreGuDingBlock(_SaleModelmodel);
    }
}
- (void)btncishuEvent{
    if (_btnCiShuGDKDBlock) {
        _btnCiShuGDKDBlock();
    }
}
- (void)btnzhekouProEvent{
    if (_btnZheKouGDKDBlock) {
        _btnZheKouGDKDBlock();
    }
}
- (void)btnquanEvent{
    if (_btnQuanGDKDBlock) {
        _btnQuanGDKDBlock();
    }
}
- (void)btnReduceGDKDEvent{
    if (_SaleModelmodel.addnum > 0) {
        _SaleModelmodel.addnum --;
    }
    if (_btnGDKDReduiceAddBlock) {
        _btnGDKDReduiceAddBlock(_SaleModelmodel,1);
    }
}
- (void)btnAddGDKDEvent{
    if (_SaleModelmodel.limit>_SaleModelmodel.addnum) {
        _SaleModelmodel.addnum ++;
        if (_btnGDKDReduiceAddBlock) {
            _btnGDKDReduiceAddBlock(_SaleModelmodel,2);
        }
    } else {
        [MzzHud toastWithTitle:@"" message:[NSString stringWithFormat:@"限购%ld次",_SaleModelmodel.limit]];
    }
}
- (void)btnShopGDKDEvent{
    switch (xiabifenlei) {
        case 1:
        {
            _SaleModelmodel.inputPrice = _textJiaGe.text;
        }
            break;
        case 10:
        {
            _SaleModelmodel.inputPrice = _textJiaGe.text;
        }
            break;
            
        default:
            break;
    }
    if (_btnShopGDKDBlock) {
        _btnShopGDKDBlock(_SaleModelmodel);
    }
}
//产品
- (void)freshGuDingProChanPinCell:(SaleModel *)model{
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    
    if (model.kill == 1) {
        _lb3.text = @"秒杀价：";
        _lb4.text = model.seckill_price;
    } else {
        _lb3.text = @"会员价：";
        _lb4.text = model.price_list.pro_12.price;
    }
    _SaleModelmodel = model;
    if (model.isShow) {
        
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        
        _lb7Top.constant = -40;
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
        
        if (model.sastoreCardModel) {
            if (model.sastoreCardModel.selected) {
                _lb10.text = model.sastoreCardModel.name;
                _SaleModelmodel.huiyuanName = model.sastoreCardModel.name;
            }else{
                _lb10.text = @"请选择优惠卡";
                _SaleModelmodel.huiyuanName = @"";
            }
        }
        if (model.staicketModel) {
            if (model.staicketModel.selected) {
                _lb12.text = model.staicketModel.name;
                _SaleModelmodel.diyongName = model.staicketModel.name;
            }else{
                _lb12.text = @"请选择抵用券";
                _SaleModelmodel.diyongName = @"";
            }
        }
        NSInteger totalprice = 0;
        if (model.sastoreCardModel) {
            if (model.sastoreCardModel.selected) {
                totalprice = model.addnum *[model.sastoreCardModel.price integerValue];
            }else{
                if (model.kill == 1) {
                    totalprice = model.addnum *[model.seckill_price integerValue];
                } else {
                    totalprice = model.addnum *[model.price_list.pro_12.price integerValue];
                }
            }
        }else{
            if (model.kill == 1) {
                totalprice = model.addnum *[model.seckill_price integerValue];
            } else {
                totalprice = model.addnum *[model.price_list.pro_11.price integerValue];
            }
        }
        if (model.staicketModel.type ==1) {
            if (model.staicketModel) {
                if (model.staicketModel.selected) {
                    totalprice = totalprice - [model.staicketModel.money floatValue];
                    if (totalprice<0) {
                        totalprice = 0;
                    }
                }
            }
        }else if (model.staicketModel.type == 3){
            if (model.staicketModel) {
                if (model.staicketModel.selected) {
                    if (totalprice >= [model.staicketModel.fulfill floatValue]) {
                        totalprice = totalprice - [model.staicketModel.price floatValue];
                        if (totalprice<0) {
                            totalprice = 0;
                        }
                    }
                }
            }
        }else if (model.staicketModel.type == 4){/** 折扣券 */
            if (model.staicketModel) {
                if (model.staicketModel.selected) {
//                    if (totalprice >= [model.staicketModel.discount floatValue]) {
                        /** lol 2019020 */
                        CGFloat tempDi = 0.0f; /** 抵用券的钱 */
                        tempDi = totalprice * (1 - model.staicketModel.discount.floatValue/10);
                        if (tempDi >= model.staicketModel.fulfill.floatValue) {
                            tempDi = model.staicketModel.fulfill.floatValue;
                        }
                        totalprice = totalprice - tempDi;
                        if (totalprice<0) {
                            totalprice = 0;
                        }
//                    }
                }
                
            }
        }else{
            
        }
        _lb14.text = [NSString stringWithFormat:@"%@",@(totalprice)];
        model.lingshouMoney = _lb4.text;

        model.totalPrice = [NSString stringWithFormat:@"%@",@(totalprice)];
        _lb9.hidden = NO;
        _lb10.hidden = NO;
        _lb11.hidden = NO;
        _lb12.hidden = NO;
        _lb13.hidden = NO;
        _lb14.hidden = NO;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = NO;
        _btnQuan.hidden = NO;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
    }else{
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = YES;
        _lb15.hidden = YES;
        _btnAdd.hidden = YES;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = YES;
    }
}
//特惠卡
- (void)freshGuDingTeHuiKaCell:(SaleModel *)model{
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb3.text = @"价格结果：";
        NSInteger totalprice = model.addnum *[model.price_list.pro_11.price integerValue];
        _lb4.text = [NSString stringWithFormat:@"%@",@(totalprice)];
        model.totalPrice = [NSString stringWithFormat:@"%@",@(totalprice)];
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        
        _lb7Top.constant = -40;
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];

        _lb9.hidden = NO;
        _lb9.text = @"包含内容：";
        if (model.isBaoHan) {
            _lb10.text = @"已选择";
        } else {
            _lb10.text = @"请选择";
        }
        model.lingshouMoney = _lb2.text;

        _lb10.hidden = NO;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = NO;
        _lb14.text = @"不赠送卡中卡奖赠内容";
        _lb14.hidden = YES;
        _lb14Top.constant = - 20;
        _lb14Leading.constant = -45;
        _lb13Top.constant = - 20;
        _lb14.textColor = kLabelText_Commen_Color_9;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = NO;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        _btnJiangZheng.selected = model.jiangzhengSelect;
        [_btnJiangZheng addTarget:self action:@selector(jiangzhengEvent) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self hiddenSomeview];
    }
}
- (void)jiangzhengEvent{
    if (_btnJiangzhengChoiseTeHuiKaBlock) {
        _btnJiangzhengChoiseTeHuiKaBlock(_SaleModelmodel);
    }
}
//任选卡
- (void)freshGuDingRenXuanCell:(SaleModel *)model{
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb3.text = @"卡项次数：";
        _lb4.text = [NSString stringWithFormat:@"%@",@(model.num)];
        _lb5.text = @"价格结果：";
        NSInteger totalprice = model.addnum *[model.price_list.pro_11.price integerValue];
        _lb6.text = [NSString stringWithFormat:@"%@",@(totalprice)];
        model.totalPrice = [NSString stringWithFormat:@"%@",@(totalprice)];
        _lb6.textColor = kLabelText_Commen_Color_3;
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
        model.lingshouMoney = _lb2.text;

        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//储值卡
- (void)freshGuDingChuZhiCell:(SaleModel *)model{
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_10.price;
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb3.text = @"价格结果：";
        NSInteger totalprice = model.addnum *[model.price_list.pro_10.price integerValue];
        _lb4.text = [NSString stringWithFormat:@"%@",@(totalprice)];
        model.totalPrice = [NSString stringWithFormat:@"%@",@(totalprice)];
        _lb4.textColor = kLabelText_Commen_Color_3;
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
        model.lingshouMoney = _lb2.text;

        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//用户自己有储值卡
- (void)freshChuZhiUserCell:(SaleModel *)model{
    xiabifenlei = 1;
    _lbTitle.text = model.name;
    _lb1.text = @"卡项归属：";
    _lb2.text = model.username;
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb3.text = @"卡项余额：";
        _lb4.text = model.money;
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            _textJiaGe.text = model.inputPrice;
            model.totalPrice = model.inputPrice;
        }
        _lb9.text = @"充值金额：";
        _btnZheKouTop.constant = -55;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.placeholder = @"请输入充值金额";
        _textJiaGe.hidden = NO;
        _btnReduce.hidden = YES;
        _lb15.hidden = YES;
        _btnAdd.hidden = YES;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//时间卡
- (void)freshGuDingshijianCell:(SaleModel *)model{
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = NO;
        _lb8.hidden = NO;
        _lb3.text = @"使用期限：";
        _lb4.text = [NSString stringWithFormat:@"%@天",@(model.expiry)];
        _lb5.text = @"会员优惠：";
        if (model.sastoreCardModel) {
            _lb6.text = model.sastoreCardModel.name;
        }else{
            _lb6.text = @"选择折扣";
        }
        _btnCiShuCenter.constant = -25;
        _lb7.text = @"价格结果：";
        NSInteger totalprice;
        if (model.sastoreCardModel) {
            totalprice = model.addnum *[model.sastoreCardModel.price integerValue];
            _lb8.text = [NSString stringWithFormat:@"%@",@(totalprice)];
        }else{
            totalprice = model.addnum *[model.price_list.pro_11.price integerValue];
            _lb8.text = [NSString stringWithFormat:@"%@",@(totalprice)];
        }
        model.totalPrice = [NSString stringWithFormat:@"%@",@(totalprice)];
        model.lingshouMoney = _lb2.text;

        _lb8.textColor = kLabelText_Commen_Color_3;
        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = NO;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
        [_btnCishu removeTarget:self action:@selector(btncishuEvent) forControlEvents:UIControlEventTouchUpInside];
        [_btnCishu addTarget:self action:@selector(btnzhekouProEvent) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self hiddenSomeview];
    }
}
//票券
- (void)freshGuDingpiaoquanCell:(SaleModel *)model{
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        
        _lb3.text = @"价格结果：";
        NSInteger totalprice = model.addnum *[model.price_list.pro_11.price integerValue];
        _lb4.text = [NSString stringWithFormat:@"%@",@(totalprice)];
        model.totalPrice = [NSString stringWithFormat:@"%@",@(totalprice)];
        _btnCiShuCenter.constant = -25;
        _lb5.text = @"详细说明：";
        _lb6.text = @"1、本代金券不得兑换";
        _lb4.textColor = kLabelText_Commen_Color_3;
        _lb6.textColor = kLabelText_Commen_Color_3;
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
        model.lingshouMoney = _lb2.text;

        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = NO;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
    }else{
        [self hiddenSomeview];
    }
}
//个性制单-项目、产品
- (void)freshGeXingProCell:(SaleModel *)model{
    xiabifenlei = 1;
    _lbTitle.text = model.name;
    _lb1.text = @"单次时长：";
    _lb2.text =[NSString stringWithFormat:@"%@",@(model.shichang)];
    _SaleModelmodel = model;
    _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = NO;
        _lb8.hidden = NO;
        _lb3.text = @"零售价：";
        _lb4.text = model.price_list.pro_11.price;
        _lb5.text = @"会员价：";
        _lb6.text = model.price_list.pro_12.price;
        _lb7.text = @"商品原价：";
        
        _lb8.textColor = kLabelText_Commen_Color_3;
        _lb9.text = @"成交价格：";
        _btnZheKouTop.constant = -5;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        
        NSString *tempprice = @"";
        tempprice = [NSString stringWithFormat:@"%@",@(model.addnum * [model.price_list.pro_11.price integerValue])];
        model.totalShangpinYuanJiaPrice = tempprice;
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            _textJiaGe.text = model.inputPrice;
            model.totalPrice = model.inputPrice;
        }else{
            model.totalPrice = tempprice;
        }
        _lb8.text = tempprice;
        _textJiaGe.hidden = NO;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//个性制单-特惠卡
- (void)freshGeXingTeHuiKaCell:(SaleModel *)model{
    xiabifenlei = 1;
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    _SaleModelmodel = model;
    _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb3.text = @"卡项次数：";
        _lb4.text = model.price_list.pro_11.num;
        
        model.totalPrice = [NSString stringWithFormat:@"%@",@(model.addnum * [model.price_list.pro_11.price integerValue])];
        
        NSString *tempprice = @"";
        tempprice = [NSString stringWithFormat:@"%@",@(model.addnum * [model.price_list.pro_11.price integerValue])];
        model.totalShangpinYuanJiaPrice = tempprice;
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            _textJiaGe.text = model.inputPrice;
            model.totalPrice = model.inputPrice;
        }else{
            model.totalPrice = tempprice;
        }
        _lb9.text = @"成交价格：";
        _btnZheKouTop.constant = -55;
        _lb10.hidden = YES;
        _lb11.hidden = NO;
        _lb12.hidden = NO;
        _lb11.text = @"包含内容：";
        if (model.isBaoHan) {
            _lb12.text = @"已选择";
        } else {
            _lb12.text = @"请选择";
        }
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        
        _textJiaGe.hidden = NO;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = NO;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//个性制单-任选卡
- (void)freshGeXingRenXuanCell:(SaleModel *)model{
    xiabifenlei = 1;
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    _SaleModelmodel = model;
    _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb3.text = @"卡项次数：";
        _lb4.text = [NSString stringWithFormat:@"%@次",@(model.limit)];
        _lb5.text = @"商品原价：";
        
        NSString *tempprice = @"";
        tempprice = [NSString stringWithFormat:@"%@",@(model.addnum * [model.price_list.pro_11.price integerValue])];
        model.totalShangpinYuanJiaPrice = tempprice;
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            _textJiaGe.text = model.inputPrice;
            model.totalPrice = model.inputPrice;
        }else{
            model.totalPrice = tempprice;
        }
        _lb6.text = tempprice;
        _lb6.textColor = kLabelText_Commen_Color_3;
        _lb9.text = @"成交价格：";
        _btnZheKouTop.constant = -30;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        
        _textJiaGe.hidden = NO;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//个性制单-时间卡
- (void)freshGeXingShiJianCell:(SaleModel *)model{
    xiabifenlei = 1;
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
    _SaleModelmodel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb3.text = @"使用期限：";
        _lb4.text = [NSString stringWithFormat:@"%@天",@(model.expiry)];
        _lb5.text = @"商品原价：";
        
        NSString *tempprice = @"";
        tempprice = [NSString stringWithFormat:@"%@",@(model.addnum * [model.price_list.pro_11.price integerValue])];
        model.totalShangpinYuanJiaPrice = tempprice;
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            _textJiaGe.text = model.inputPrice;
            model.totalPrice = model.inputPrice;
        }else{
            model.totalPrice = tempprice;
        }
        _lb6.text = tempprice;
        
        _lb6.textColor = kLabelText_Commen_Color_3;
        _lb9.text = @"成交价格：";
        _btnZheKouTop.constant = -30;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        
        _textJiaGe.hidden = NO;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//个性制单-票券
- (void)freshGeXingPiaoQuanCell:(SaleModel *)model{
    xiabifenlei = 1;
    _lbTitle.text = model.name;
    _lb1.text = @"零售价：";
    _lb2.text = model.price_list.pro_11.price;
    _SaleModelmodel = model;
    _lb15.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lb8.hidden = YES;
        _lb3.text = @"商品原价：";
        
        NSString *tempprice = @"";
        tempprice = [NSString stringWithFormat:@"%@",@(model.addnum * [model.price_list.pro_11.price integerValue])];
        model.totalShangpinYuanJiaPrice = tempprice;
        if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
            _textJiaGe.text = model.inputPrice;
            model.totalPrice = model.inputPrice;
        }else{
            model.totalPrice = tempprice;
        }
        _lb4.text = tempprice;
        
        _btnCiShuCenter.constant = -25;
        _lb9.text = @"成交价格：";
        _btnZheKouTop.constant = -30;
        _lb4.textColor = kLabelText_Commen_Color_3;
        
        _lb9.hidden = NO;
        _lb10.hidden = YES;
        _lb11.hidden = NO;
        _lb12.hidden = NO;
        _lb11.text = @"详细说明：";
        _lb12.text = @"1、本代金券不得兑换";
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = NO;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = NO;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        
    }else{
        [self hiddenSomeview];
    }
}
//已购置换-项目
- (void)freshYiGouZhiHuanProOneCell:(SAZhiHuanPorModel *)model QuanBuState:(BOOL)state{
    _sAZhiHuanPorModel = model;
    _lbTitle.text = model.name;
    _lb1.text = @"剩余金额：";
    _lb2.text = [NSString stringWithFormat:@"%@",@(model.money)];
    _sAZhiHuanPorModel = model;
    if (model.isShow) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = NO;
        _lb8.hidden = NO;
        _lb3.text = @"剩余次数：";
        _lb4.text = [NSString stringWithFormat:@"%@",@(model.nums)];
        _lb5.text = @"项目单价：";
        _lb6.text = [NSString stringWithFormat:@"%@",@(model.price)];
        _lb7.text = @"回收金额：";
        if (model.isQuanBuHuiShou) {
            _lb8.text = [NSString stringWithFormat:@"%@",@(model.money)];
        } else {
            _lb8.text = [NSString stringWithFormat:@"%@",@(model.price*model.numDisPlay)];
        }
        model.totalPrice = _lb8.text;
        _lb8.textColor = kLabelText_Commen_Color_3;
        _lb15.text = [NSString stringWithFormat:@"%@",@(model.numDisPlay)];
        _lb9.hidden = YES;
        _lb10.hidden = YES;
        _lb11.hidden = YES;
        _lb12.hidden = YES;
        _lb13.hidden = YES;
        _lb14.hidden = YES;
        _textJiaGe.hidden = YES;
        _btnReduce.hidden = NO;
        _lb15.hidden = NO;
        _btnAdd.hidden = NO;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        _btnQuanBu.hidden = state;
    }else{
        [self hiddenSomeview];
    }
    
    [_btnMore removeTarget:self action:@selector(btnMoreGuDingEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnMore addTarget:self action:@selector(btnYiGouZhiHuanMoreEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnReduce removeTarget:self action:@selector(btnReduceGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnReduce addTarget:self action:@selector(btnReduceYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnAdd removeTarget:self action:@selector(btnAddGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(btnAddYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnShop removeTarget:self action:@selector(btnShopGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopYGZHEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnYiGouZhiHuanMoreEvent{
    _sAZhiHuanPorModel.isShow = !_sAZhiHuanPorModel.isShow;
    if (_btnMoreYiGouZhiHuanBlock) {
        _btnMoreYiGouZhiHuanBlock(_sAZhiHuanPorModel);
    }
}
- (void)btnReduceYGZHEvent{
    if (_sAZhiHuanPorModel.numDisPlay > 0) {
        _sAZhiHuanPorModel.numDisPlay --;
    }
    if (_btnYGZHReduiceAddBlock) {
        _btnYGZHReduiceAddBlock(_sAZhiHuanPorModel,1);
    }
}
- (void)btnAddYGZHEvent{
    if (_sAZhiHuanPorModel.nums > _sAZhiHuanPorModel.numDisPlay) {
        _sAZhiHuanPorModel.numDisPlay ++;
        if (_btnYGZHReduiceAddBlock) {
            _btnYGZHReduiceAddBlock(_sAZhiHuanPorModel,2);
        }
    }else{
        [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
    }
}
- (void)btnShopYGZHEvent{
    if (_btnShopYiGouZhiHuanBlock) {
        _btnShopYiGouZhiHuanBlock(_sAZhiHuanPorModel);
    }
}
//已购置换-定金订单
- (void)freshYiGouZhiHuanDingJinDingDanCell:(SADepositListModelSales *)model{
    _lbTitle.text = [NSString stringWithFormat:@"订单编号：\n%@",model.ordernum];
    _lbTitle.numberOfLines = 2;
    _lbTitle.font = [UIFont systemFontOfSize:12];
    _lb1.text = @"冻结金额：";
    _lb2.text = [NSString stringWithFormat:@"%@",@(model.tk_amount)];
    _sADepositListModelSales = model;
    if (model.isShow) {
        _lb3.text = @"开单人：";
        _lb4.text = model.inper;
        _lb5.text = @"开单类型：";
        _lb6.text = model.type;
        _lb7.text = @"应付金额：";
        _lb8.text = model.heji;
        _lb9.text = @"实付金额：";
//        _lb10.text = model.amount;
        _lb10.hidden = YES;
        _textJiaGe.text = model.amount;
        _textJiaGe.userInteractionEnabled = NO;
        _lb11.text = @"开单时间：";
        _lb16.hidden = NO;
        _lb16.text = model.insert_time;
        _lb12.hidden = YES;
        _lb13.text = @"回收金额：";
        _lb14.text = [NSString stringWithFormat:@"%@",@(model.tk_amount)];
        _btnZheKouTop.constant = -5;
        _btnQuanTop.constant = -5;
        _textJiaGe.hidden = NO;
        _lb12Leading.constant = -5;
        _lb15.hidden = YES;
        _btnReduce.hidden = YES;
        _btnAdd.hidden = YES;
        _btnCishu.hidden = YES;
        _btnZhekou.hidden = YES;
        _btnQuan.hidden = YES;
        _btnJiangZheng.hidden = YES;
        _btnShop.hidden = NO;
        _sADepositListModelSales.numDisPlay = 1;
    }else{
        [self hiddenSomeview];
    }
    [_btnMore removeTarget:self action:@selector(btnMoreGuDingEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnMore addTarget:self action:@selector(btnMoreYiGouZhiHuanDingJinEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnReduce removeTarget:self action:@selector(btnReduceGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnReduce addTarget:self action:@selector(btnReduceDingJinEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnAdd removeTarget:self action:@selector(btnAddGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(btnAddDingJinEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnShop removeTarget:self action:@selector(btnShopGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnShopDingJinEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnMoreYiGouZhiHuanDingJinEvent{
    _sADepositListModelSales.isShow = !_sADepositListModelSales.isShow;
    if (_btnMoreYiGouZhiHuanDingJinBlock) {
        _btnMoreYiGouZhiHuanDingJinBlock(_sADepositListModelSales);
    }
}
- (void)btnReduceDingJinEvent{
    if (_sADepositListModelSales.numDisPlay > 0) {
        _sADepositListModelSales.numDisPlay --;
    }
    if (_btnYGZHReduiceAddDingJinBlock) {
        _btnYGZHReduiceAddDingJinBlock(_sADepositListModelSales,1);
    }
}
- (void)btnAddDingJinEvent{
    if (_sADepositListModelSales.numDisPlay==1) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"超出数量"];
        if (_btnYGZHReduiceAddDingJinBlock) {
            _btnYGZHReduiceAddDingJinBlock(_sADepositListModelSales,2);
        }
        return;
    }
    _sADepositListModelSales.numDisPlay ++;
    if (_btnYGZHReduiceAddDingJinBlock) {
        _btnYGZHReduiceAddDingJinBlock(_sADepositListModelSales,2);
    }
//    if (_sAZhiHuanPorModel.nums > _sAZhiHuanPorModel.numDisPlay) {
//        _sAZhiHuanPorModel.numDisPlay ++;
//        if (_btnYGZHReduiceAddDingJinBlock) {
//            _btnYGZHReduiceAddDingJinBlock(_sADepositListModelSales,2);
//        }
//    }else{
//        [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
//    }
}
- (void)btnShopDingJinEvent{
    [self textFieldDidEndEditing:_textJiaGe];
    if (_btnShopDingJinBlock) {
        _btnShopDingJinBlock(_sADepositListModelSales);
    }
}
- (void)freshKSZHUserProOneCell:(SAAccountModel *)model userName:(NSString *)name{
    xiabifenlei = 10;
    _lbTitle.text = [NSString stringWithFormat:@"账号ID：%ld",model.data.bank.bank_id];
    _lb1.text = @"账户归属：";
    _lb2.text = name;
    _lb3.text = @"账户余额：";
    _lb4.text = model.data.bank.money;
    _lb9.text = @"账户充值：";
    _textJiaGe.placeholder = @"请输入金额";
    if (model.inputPrice&&model.inputPrice.length>0&&(![model.inputPrice isEqualToString:@""])) {
        _textJiaGe.text = model.inputPrice;
        model.inputPrice = model.inputPrice;
    }
    _SAAccountModelmodel = model;
    _lb5.hidden = YES;
    _lb6.hidden = YES;
    _lb7.hidden = YES;
    _lb8.hidden = YES;
    
    _lb10.hidden = YES;
    _lb11.hidden = YES;
    _lb12.hidden = YES;
    _lb13.hidden = YES;
    _lb14.hidden = YES;
    
    _btnZheKouTop.constant = -55;
    
    _btnMore.hidden = YES;
    _btnReduce.hidden = YES;
    _lb15.hidden = YES;
    _btnAdd.hidden = YES;
    _btnCishu.hidden = YES;
    _btnZhekou.hidden = YES;
    _btnQuan.hidden = YES;
    _btnJiangZheng.hidden = YES;
    
    [_btnShop removeTarget:self action:@selector(btnShopGDKDEvent) forControlEvents:UIControlEventTouchUpInside];
    [_btnShop addTarget:self action:@selector(btnKSZHUserEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnKSZHUserEvent{
    
    if (!_textJiaGe.text || [_textJiaGe.text isEqualToString:@""]) {
        [MzzHud toastWithTitle:@"温馨提示" message:@"请填写金额"];
        return ;
    }
    [self textFieldDidEndEditing:_textJiaGe];
    if (_btnShopKSZHUserBlock) {
        _btnShopKSZHUserBlock(_SAAccountModelmodel);
    }
}
- (void)hiddenSomeview{
    _lb3.hidden = YES;
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    _lb6.hidden = YES;
    _lb7.hidden = YES;
    _lb8.hidden = YES;
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    _lb11.hidden = YES;
    _lb12.hidden = YES;
    _lb13.hidden = YES;
    _lb14.hidden = YES;
    
    _textJiaGe.hidden = YES;
    _btnReduce.hidden = YES;
    _lb15.hidden = YES;
    _btnAdd.hidden = YES;
    _btnCishu.hidden = YES;
    _btnZhekou.hidden = YES;
    _btnQuan.hidden = YES;
    _btnJiangZheng.hidden = YES;
    _btnShop.hidden = YES;
    _btnQuanBu.hidden = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
