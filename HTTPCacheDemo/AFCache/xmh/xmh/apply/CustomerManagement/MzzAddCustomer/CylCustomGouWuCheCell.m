//
//  CylCustomGouWuCheCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/21.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CylCustomGouWuCheCell.h"

@implementation CylCustomGouWuCheCell{
    NSDictionary *_dic;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)freshCylCustomGouWuCheCell:(NSDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买金额：";
    _lb3.text = [NSString stringWithFormat:@"%@元",dic[@"denomination"]];
    _lb2.text = @"余额：";
    _lb4.text = [NSString stringWithFormat:@"%@元",dic[@"money"]];
}
- (void)freshCylCustomTimeGouWuCheCell:(NSDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买日期：";
    _lb3.text = dic[@"pay_time"];
    _lb2.text = @"截止日期：";
    _lb4.text = dic[@"end_time"];
}
- (void)freshCylCustomNumGouWuCheCell:(NSDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买次数：";
    _lb3.text = dic[@"num"];
    _lb2.text = @"剩余次数：";
    _lb4.text = dic[@"sheng_num"];
}
- (void)freshCylCustomGoodsGouWuCheCell:(NSDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买日期：";
    _lb3.text = dic[@"pay_time"];
    _lb2.text = @"购买金额：";
    _lb4.text = [NSString stringWithFormat:@"%@元",dic[@"amount"]];
}
- (void)freshCylCustomTicketGouWuCheCell:(NSDictionary *)dic{
    _dic = dic;
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买日期：";
    _lb3.text = dic[@"pay_time"];
    _lb2.text = @"购买金额：";
    _lb4.text = [NSString stringWithFormat:@"%@元",dic[@"money"]];
}
- (IBAction)btnDelEvetn:(UIButton *)sender {
    if (_btnCylCustomGouWuCheCellDelBlock) {
        _btnCylCustomGouWuCheCellDelBlock(_dic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
