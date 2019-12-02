//
//  MzzBillSaleDetailCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/16.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzBillSaleDetailCell.h"
#import "MzzBillInfoListModel.h"
@interface MzzBillSaleDetailCell ()
//@property (weak, nonatomic) IBOutlet UILabel *jinecishu;
//@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *mingcheng;
@property (weak, nonatomic) IBOutlet UILabel *leixing;
@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyidanhao;
@property (weak, nonatomic) IBOutlet UILabel *shengyujine;
@property (weak, nonatomic) IBOutlet UILabel *dongjie;

@end
@implementation MzzBillSaleDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupModel:(MzzBillInfoModel *)model andType:(NSString *)type andCardName:(NSString *)cardName{
//    _jinecishu.text = model.name;
    _mingcheng.text = [NSString stringWithFormat:@"名称：%@",cardName];
//    _money.text = model.show;
    _leixing.text = [NSString stringWithFormat:@"类型：%@",model.ly_name];
    _shijian.text = [NSString stringWithFormat:@"时间：%@",model.insert_time];
    _jiaoyidanhao.text = [NSString stringWithFormat:@"交易单号：%@",model.ordernum];
    if ([model.name isEqualToString:@"金额"]) {
        _shengyujine.text =[NSString stringWithFormat:@"剩余金额：%@元", model.current];
    }else{
        _shengyujine.text =[NSString stringWithFormat:@"剩余次数：%ld次", model.alter_num];
    }
    if ([model.ly_type isEqualToString:@"approval_changeorder_reg"]) {
        _shengyujine.hidden = YES;
    }else{
        _shengyujine.hidden = NO;
    }
    NSString * dongjie = @"";
    if (model.frozen.integerValue == 1) {
        dongjie = @"开始冻结";
    }
    if (model.frozen.integerValue == 2) {
        dongjie = @"冻结结束";
    }
    if (!(model.frozen.integerValue == 1 ||model.frozen.integerValue == 2)) {
        _dongjie.hidden = YES;
    }
    _dongjie.text = dongjie;
}
@end
