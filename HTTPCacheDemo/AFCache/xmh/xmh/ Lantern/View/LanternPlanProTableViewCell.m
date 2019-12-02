//
//  LanternPlanProTableViewCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/26.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternPlanProTableViewCell.h"

@implementation LanternPlanProTableViewCell
{
    SaleModel *_SaleModelmodel;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)freshGuDingProOneCell:(SaleModel *)model{
   
    _SaleModelmodel = model;
    self.titleLabel.text = model.name;
    NSArray *arrNum = [model.price_list.pro_21.num componentsSeparatedByString:@","];
    NSArray *arrLingShou = [model.price_list.pro_21.price componentsSeparatedByString:@","];
    
    if (model.ciShu) {
        for (NSInteger i=0; i<arrNum.count; i++) {
            NSString *tmpCiShu = arrNum[i];
            if ([model.ciShu isEqualToString:tmpCiShu]) {
                if (i<arrLingShou.count) {
                    self.priceLabel.text = arrLingShou[i];
                }
                break;
            }
        }
    }else{
        if (arrLingShou.count > 0) {
            self.priceLabel.text = arrLingShou[0];
        }
    }
    if (model.addnum == 0) {
        self.btnReduce.hidden = YES;
        self.numLabel.text = @"";
    }else{
        self.numLabel.text = [NSString stringWithFormat:@"%@",@(model.addnum)];
    }
    
}
- (IBAction)btnReduceGDKDEvent:(id)sender {
    if (_SaleModelmodel.addnum > 0) {
        _SaleModelmodel.addnum --;
    }
    if (_btnGDKDReduiceAddBlock) {
        _btnGDKDReduiceAddBlock(_SaleModelmodel,1);
    }
}
- (IBAction)btnAddGDKDEvent:(id)sender {
    if (_SaleModelmodel.limit>_SaleModelmodel.addnum) {
        _SaleModelmodel.addnum ++;
        if (_btnGDKDReduiceAddBlock) {
            _btnGDKDReduiceAddBlock(_SaleModelmodel,2);
        }
    } else {
        [MzzHud toastWithTitle:@"" message:[NSString stringWithFormat:@"限购%ld次",_SaleModelmodel.limit]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
