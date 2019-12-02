//
//  SaleServiceJishiCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/13.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SaleServiceJishiCell.h"

@implementation SaleServiceJishiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //beautyxuanzhong
}
-(void)freshSaleServiceJishiCell:(MLJiShiModel *)model{
    _lb1.text = model.name;
    _lb2.text = model.phone;
    _lb3.text = model.store_name;
    if (model.isSelect) {
        _im.image = [UIImage imageNamed:@"beautyxuanzhong.png"];
    }else{
        _im.image = [UIImage imageNamed:@"beautyweixuanzhong.png"];
    }
}

- (void)freshSaleServiceShenpiCell:(LJiangZengPersonModel *)model{
    _lb1.text = model.name;
//    _lb2.text = model.phone;
    _lb3.text = model.frame_name;
    if (model.isSelect) {
        _im.image = [UIImage imageNamed:@"beautyxuanzhong.png"];
    }else{
        _im.image = [UIImage imageNamed:@"beautyweixuanzhong.png"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
