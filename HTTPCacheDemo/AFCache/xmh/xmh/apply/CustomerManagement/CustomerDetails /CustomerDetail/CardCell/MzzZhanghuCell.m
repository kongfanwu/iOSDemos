//
//  MzzZhanghuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzZhanghuCell.h"
@interface MzzZhanghuCell ()
@property (weak, nonatomic) IBOutlet UILabel *zhanghuyue;
@property (weak, nonatomic) IBOutlet UILabel *chuangjianshijian;
@property (weak, nonatomic) IBOutlet UILabel *lbDongJie;

@end
@implementation MzzZhanghuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MzzBankModel *)model{
    _model = model;
    [_zhanghuyue setText: [NSString stringWithFormat:@"账户余额：%@元",model.money]];
    [_chuangjianshijian setText:[NSString stringWithFormat:@"创建时间：%@",model.insert_time]];
    _lbDongJie.text = model.dj_amount;
}
@end
