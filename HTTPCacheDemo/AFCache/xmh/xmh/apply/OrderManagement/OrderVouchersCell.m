//
//  OrderVouchersCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/10/29.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "OrderVouchersCell.h"

@implementation OrderVouchersCell
{
    SATicketModel *_SATicketModelcishumodel;
    SellProTicketModel *_sellTicketModelcishumodel;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)freshSKXKDiYongQuanCell:(SATicketModel *)model{
    _SATicketModelcishumodel = model;
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"%@%@-%@",@"有效期：",model.start_time,model.end_time];
    _btn.selected = model.selected;
    if (model.type == 1) {
        self.typeImageView.image = [UIImage imageNamed:@"daijinquan"];
        self.imageWeiK.hidden = YES;
        self.lbGuiZ.hidden = YES;
    }else if (model.type == 3){
        self.typeImageView.image = [UIImage imageNamed:@"xianjinquan"];
        self.imageWeiK.hidden = NO;
        self.lbGuiZ.hidden = NO;
    }else{
        self.typeImageView.image = [UIImage imageNamed:@"zhekouquan"];
        self.imageWeiK.hidden = NO;
        self.lbGuiZ.hidden = NO;
    }

    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(btnDiYongQuanEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)freshSellProDiYongQuanCell:(SellProTicketModel *)model{
    _sellTicketModelcishumodel = model;
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"%@%@-%@",@"有效期：",model.start_time,model.end_time];
    _btn.selected = model.selected;
    self.typeImageView.image = [UIImage imageNamed:@"lipinquan"];
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuanweixuan"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"stgkgl_danxuan"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(btnSellDiYongQuanEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnDiYongQuanEvent{
    _SATicketModelcishumodel.selected = !_SATicketModelcishumodel.selected;
    if (_btnSKXKDiYongQuanCellBlock) {
        _btnSKXKDiYongQuanCellBlock(_SATicketModelcishumodel);
    }
}
- (void)btnSellDiYongQuanEvent{
    _sellTicketModelcishumodel.selected = !_sellTicketModelcishumodel.selected;
    if (_btnSellProDiYongQuanCellBlock) {
        _btnSellProDiYongQuanCellBlock(_sellTicketModelcishumodel);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
