//
//  MzzXiaoFeiJiLuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzXiaoFeiJiLuCell.h"
#import "MzzConsumption_salesListModel.h"
@interface MzzXiaoFeiJiLuCell ()
@property (weak, nonatomic) IBOutlet UIView *ctView;
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *jineleiji;
@property (weak, nonatomic) IBOutlet UILabel *jiangetian;
@property (weak, nonatomic) IBOutlet UILabel *shijian;

@end
@implementation MzzXiaoFeiJiLuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_ctView.layer setBorderColor:kLabelText_Commen_Color_6.CGColor];
    [_ctView.layer setBorderWidth:1];
    [_ctView.layer setCornerRadius:5];
    [_ctView.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MzzConsumption_salesModel *)model{
    _model = model;
    [_code setText:model.ordernum];
    [_name setText:model.name];
    [_jineleiji setText:[NSString stringWithFormat:@"金额/累计：%@元/%ld元",model.amount,model.leiji]];
    [_jiangetian setText:[NSString stringWithFormat:@"间隔/天：%ld天",model.jg]];
    [_shijian setText:model.buying_time];
}
@end
