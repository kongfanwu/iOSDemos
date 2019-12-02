//
//  LDealProjectCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDealProjectCell.h"

@implementation LDealProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
- (void)updateLDealProjectCellWithModel:(OHomeModel *)homeModel type:(NSInteger)type
{
    NSString * typeName = @"";
    if (type == 1) {
        typeName = @"门店名称:";
    }else if (type ==2){
         typeName = @"项目名称:";
    }
    _lb1.text = typeName;
    _lb11.text = homeModel.name;
    _lb2.text = @"成交订单数量:";
    _lb22.text = homeModel.deal;
    _lb3.text = @"新增顾客:";
    _lb33.text = homeModel.add;
    _lb4.text = @"参与人数:";
    _lb44.text = homeModel.num;
    _lb5.text = @"交易金额:";
    _lb55.text = homeModel.amount;
}
@end
