//
//  LOrderDetailCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/2.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LOrderDetailCell.h"

@implementation LOrderDetailCell

@synthesize imageView = _imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb7.hidden = YES;
    _lbTime.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)refreshLOrderDetailCell:(tempModel *)model
{
     _v2.hidden = !model.isShow;
}
- (void)setTuiKuanModel:(SATuiKuanModel *)tuiKuanModel
{
    _lbName.text = [NSString stringWithFormat:@"%@%@",tuiKuanModel.user_name,@":"];
    _lbCode.text = tuiKuanModel.code;
    _lb1.text = [NSString stringWithFormat:@"顾客姓名：%@",tuiKuanModel.user_name];
    _lb2.text = [NSString stringWithFormat:@"顾客电话：%@",tuiKuanModel.user_mobile];
    _lb3.text = [NSString stringWithFormat:@"所属门店：%@",tuiKuanModel.store_name];
    _lb4.text = [NSString stringWithFormat:@"发起人：%@",tuiKuanModel.inper_name];
    _lb5.text = [NSString stringWithFormat:@"发起时间：%@",tuiKuanModel.create_time];
    _lb6.text = [NSString stringWithFormat:@"退款金额：%ld",tuiKuanModel.actual];
    _lbState.hidden = YES;
    [self changeImageView];
}
//配合消费
- (void)setCooperateModel:(SLCooperate *)cooperateModel
{
    _lb7.hidden = NO;
    _lbTime.hidden = NO;
    _lbName.text = [NSString stringWithFormat:@"%@%@",cooperateModel.user_name,@":"];
    _lbCode.text = cooperateModel.ordernum;
    _lb1.text = [NSString stringWithFormat:@"开单人：%@",cooperateModel.saler];
    _lb2.text = [NSString stringWithFormat:@"开单类型：%@",cooperateModel.type_name];
    _lb3.text = [NSString stringWithFormat:@"顾客姓名：%@",cooperateModel.user_name];
    _lb4.text = [NSString stringWithFormat:@"手机号：%@",cooperateModel.user_mobile];
    _lb5.text = [NSString stringWithFormat:@"实付金额：%ld",cooperateModel.pay_zt];
    _lb6.text = [NSString stringWithFormat:@"结算时间：%@",cooperateModel.pay_time];
    _lb7.text = [NSString stringWithFormat:@"项目名称：%@",cooperateModel.type_name];
    _lbTime.text = [NSString stringWithFormat:@"%@",cooperateModel.insert_time];
    _lbState.text = [NSString stringWithFormat:@"%@",cooperateModel.order_type_name];
    UIColor *color;
    if ([_lbState.text isEqualToString:@"待结算"]) {
        color = [ColorTools colorWithHexString:@"#FF9072"];
    }else if ([_lbState.text isEqualToString:@"已完成"]){
        color = [ColorTools colorWithHexString:@"#999999"];
    }else if ([_lbState.text isEqualToString:@"已代收"]){
        color = [ColorTools colorWithHexString:@"#B9B8FB"];
    }else{
        color = [ColorTools colorWithHexString:@"#48C2AF"];
    }
    _lbState.textColor = color;
    [self changeImageView];

}
//配合耗卡
- (void)setHaokacooperateModel:(SLCooperate *)haokacooperateModel
{
    _lb7.hidden = NO;
    _lbTime.hidden = NO;
    _lbName.text = [NSString stringWithFormat:@"%@%@",haokacooperateModel.user_name,@":"];
    _lbCode.text = haokacooperateModel.ordernum;
    _lb1.text = [NSString stringWithFormat:@"开单人：%@",haokacooperateModel.inper_name];
    _lb2.text = [NSString stringWithFormat:@"开单类型：%@",haokacooperateModel.type_name];
    _lb3.text = [NSString stringWithFormat:@"顾客姓名：%@",haokacooperateModel.user_name];
    _lb4.text = [NSString stringWithFormat:@"手机号：%@",haokacooperateModel.mobile];
    _lb5.text = [NSString stringWithFormat:@"消耗金额：%@",haokacooperateModel.z_price];
    _lb6.text = [NSString stringWithFormat:@"结算时间：%@",haokacooperateModel.etime];
    _lb7.text = [NSString stringWithFormat:@"项目名称：%@",haokacooperateModel.type_name];
    _lbTime.text = [NSString stringWithFormat:@"%@",haokacooperateModel.stime];
    _lbState.text = [NSString stringWithFormat:@"%@",haokacooperateModel.order_type_name];
    UIColor *color;
    if ([_lbState.text isEqualToString:@"待结算"]) {
        color = [ColorTools colorWithHexString:@"#FF9072"];
    }else if ([_lbState.text isEqualToString:@"已完成"]){
        color = [ColorTools colorWithHexString:@"#999999"];
    }else if ([_lbState.text isEqualToString:@"已代收"]){
        color = [ColorTools colorWithHexString:@"#B9B8FB"];
    }else{
        color = [ColorTools colorWithHexString:@"#48C2AF"];
    }
    _lbState.textColor = color;

    [self changeImageView];

}
- (void)setYejiModel:(LOrderYejiModel *)yejiModel
{
    _lbName.text = [NSString stringWithFormat:@"%@%@",yejiModel.user_name,@":"];
    _lbCode.text = yejiModel.ordernum;
    _lb3.text = [NSString stringWithFormat:@"开单人：%@",yejiModel.saler];
    _lb4.text = [NSString stringWithFormat:@"开单类型：%@",yejiModel.type_name];
    _lb1.text = [NSString stringWithFormat:@"顾客：%@",yejiModel.user_name];
    _lb2.text = [NSString stringWithFormat:@"电话：%@",yejiModel.user_mobile];
    _lb5.hidden = YES;
    _lb6.hidden = YES;
    _lb7.hidden = YES;
    _lbTime.text = [NSString stringWithFormat:@"%@",yejiModel.insert_time];

    _lbState.text = yejiModel.order_type_name;
    UIColor *color;
    if ([_lbState.text isEqualToString:@"待结算"]) {
        color = [ColorTools colorWithHexString:@"#FF9072"];
    }else if ([_lbState.text isEqualToString:@"已完成"]){
        color = [ColorTools colorWithHexString:@"#999999"];
    }else if ([_lbState.text isEqualToString:@"已代收"]){
        color = [ColorTools colorWithHexString:@"#B9B8FB"];
    }else{
        color = [ColorTools colorWithHexString:@"#48C2AF"];
    }
    _lbState.textColor = color;
    [self changeImageView];
}
-(void)changeImageView
{
    if (!_v2.hidden) {
        [UIView animateWithDuration:0 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    else
    {
        if (!_v2.hidden) {
            [UIView animateWithDuration:0 animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }else{
            [UIView animateWithDuration:0 animations:^{
                self.imageView.transform = CGAffineTransformIdentity;
            }];
        }
    }
}
@end
