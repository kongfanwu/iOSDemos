//
//  OrderSaleSearchCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OrderSaleSearchCell.h"
#import <YYWebImage/YYWebImage.h>

@implementation OrderSaleSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)freshOrderSaleSearchCell:(CustomerModel *)model{
    [_im1 yy_setImageWithURL:[NSURL URLWithString:model.user_headimgurl] placeholder:kDefaultCustomerImage];
    _lb1.text = model.uname;
    _lb2.text = model.grade_name;
    _lb3.text = model.mobile;
}
-(void)freshOrderCell:(SANewDingDanModel *)model
{
    [_im1 yy_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholder:kDefaultCustomerImage];
    _lb1.text = model.user_name;
    if (model.grade_name.length!=0) {
        _lb2.text = model.grade_name;
    }else{
        _lb2.text = @"无";
    }
    _lb3.text = model.user_mobile;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
