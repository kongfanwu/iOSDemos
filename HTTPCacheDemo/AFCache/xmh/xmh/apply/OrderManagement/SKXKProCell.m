//
//  SKXKProCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SKXKProCell.h"

@implementation SKXKProCell
{
    ShengKaXuKaProDataList *_model;
    
    ShengKaXuKaKeShengHuiYuanKaList *_mubiaoModel;
    
    ZheKouStored_Card *_ZheKouHuiYuanStored_Cardmodel;
    
    CiShuModel *_CiShuModelcishumodel;
    
    SATicketModel *_SATicketModelcishumodel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)freshSKXKProCell:(ShengKaXuKaProDataList *)model{
    _model = model;
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"%@次",@(model.nums)];
    _lb3.text = [NSString stringWithFormat:@"%@",@(model.price)];
    _btn.selected = model.selected;
    [_btn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnEvent{
    _model.selected = !_model.selected;
    if (_btnSKXKProCellBlock) {
        _btnSKXKProCellBlock(_model);
    }
}

- (void)freshSKXKMuBiaoCell:(ShengKaXuKaKeShengHuiYuanKaList *)model{
    _mubiaoModel = model;
    _lb1.text = model.name;
    _lb2.text = model.denomination;
    _lb3.text = model.price;
    _btn.selected = model.selected;
    _lb11.text = @"面额：";
    _lb12.text = @"价格：";
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(btnMuBiaoEvent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnMuBiaoEvent{
    _mubiaoModel.selected = !_mubiaoModel.selected;
    if (_btnSKXKMuBiaoCellBlock) {
        _btnSKXKMuBiaoCellBlock(_mubiaoModel);
    }
}
- (void)freshSKXKZheKouCell:(ZheKouStored_Card *)model{
    _ZheKouHuiYuanStored_Cardmodel = model;
    _lb1.text = model.name;
    _lb2.text = model.money;
    _lb3.text = model.price;
    _btn.selected = model.selected;
    _lb11.text = @"储值卡余额：";
    _lb12.text = @"折扣价后价格：";
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(btnZheKouEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnZheKouEvent{
    _ZheKouHuiYuanStored_Cardmodel.selected = !_ZheKouHuiYuanStored_Cardmodel.selected;
    if (_btnSKXKZheKouCellBlock) {
        _btnSKXKZheKouCellBlock(_ZheKouHuiYuanStored_Cardmodel);
    }
}

- (void)freshSKXKCiShuCell:(CiShuModel *)cishumodel{
    _CiShuModelcishumodel = cishumodel;
    _lb1.hidden = YES;
    _lb2.text = cishumodel.cishu;
    _lb3.hidden = YES;
    _btn.selected = cishumodel.selected;
    _lb11.text = @"疗程次数：";
    _lb12.hidden = YES;
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(btnChishuEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnChishuEvent{
    _CiShuModelcishumodel.selected = !_CiShuModelcishumodel.selected;
    if (_btnSKXKCiShuCellBlock) {
        _btnSKXKCiShuCellBlock(_CiShuModelcishumodel);
    }
}

- (void)freshSKXKDiYongQuanCell:(SATicketModel *)model{
    _SATicketModelcishumodel = model;
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"%@-%@",model.start_time,model.end_time];
    _lb3.hidden = YES;
    _btn.selected = model.selected;
    _lb11.text = @"有效期：";
    _lb12.hidden = YES;
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(btnDiYongQuanEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnDiYongQuanEvent{
    _SATicketModelcishumodel.selected = !_SATicketModelcishumodel.selected;
    if (_btnSKXKDiYongQuanCellBlock) {
        _btnSKXKDiYongQuanCellBlock(_SATicketModelcishumodel);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
