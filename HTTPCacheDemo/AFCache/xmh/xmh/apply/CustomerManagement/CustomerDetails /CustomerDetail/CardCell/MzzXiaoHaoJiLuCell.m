//
//  MzzXiaoHaoJiLuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzXiaoHaoJiLuCell.h"
#import "MzzConsumptionListModel.h"
@interface MzzXiaoHaoJiLuCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *xiaohaojine;
@property (weak, nonatomic) IBOutlet UILabel *xiangmushu;
@property (weak, nonatomic) IBOutlet UILabel *leijidaodian;
@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *tip;

@end
@implementation MzzXiaoHaoJiLuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tip.layer.cornerRadius = 5.f;
    _tip.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MzzConsumptionModel *)model{
    _model = model;
    [_name setText:model.ordernum];
    [_xiaohaojine setText:model.z_price];
    [_xiangmushu setText:[NSString stringWithFormat:@"项目数：%ld",model.num]];
    [_leijidaodian setText:[NSString stringWithFormat:@"累计到店：%ld",model.daodian]];
    [_shijian setText:model.day];
}
@end
