//
//  MzzXiangMuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzXiangMuCell.h"
#import "LolMarkView.h"
@interface MzzXiangMuCell()
@property (weak, nonatomic) IBOutlet UIImageView *fenqi;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet LolMarkView *markView;
@property (weak, nonatomic) IBOutlet UILabel *goumaishijian;
@property (weak, nonatomic) IBOutlet LolMarkView *markView2;
@property (weak, nonatomic) IBOutlet UILabel *chufangjine;
@property (weak, nonatomic) IBOutlet UILabel *dongjiejine;
@property (weak, nonatomic) IBOutlet UILabel *shangpinjine;
@property (weak, nonatomic) IBOutlet UILabel *yue;
@property (weak, nonatomic) IBOutlet UILabel *shengyudongjie;
@property (weak, nonatomic) IBOutlet UILabel *chufangcishu;
@property (weak, nonatomic) IBOutlet UILabel *statue;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1W;

@end
@implementation MzzXiangMuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MzzProModel *)model{
    _model = model;
    if (_model.fenqi_zt ==2) {
        [_fenqi setImage:[UIImage imageNamed:@"yihuanqing"]];
    }else if (model.fenqi_zt ==1){
        [_fenqi setImage:[UIImage imageNamed:@"fenqi"]];
    }else{
        [_fenqi setImage:nil];
    }
    [_name setText:model.name?model.name:@"无" ];
    [_markView lolMarkViewImageName:@"bookbiaoqian" Title:model.ly_type_name];
    if (model.is_jz ==1) {
        [_markView2 lolMarkViewImageName:@"bookbiaoqian" Title:@"奖赠"];
    }else {
        _markView2.hidden = YES;
    }
    [_goumaishijian setText:[@"购买时间：" stringByAppendingString:model.insert_time]];
    [_chufangjine setText:[@"处方金额：" stringByAppendingString:[NSString stringWithFormat:@"%ld元",model.dj_amount]]];
    [_dongjiejine setText:[@"冻结金额：" stringByAppendingString:[NSString stringWithFormat:@"%ld元",model.dj_amount_wrz]]];
    [_shangpinjine setText:[NSString stringWithFormat:@"商品金额：%@元",model.amount_a]];
    [_yue setText: [NSString stringWithFormat:@"余额：%@元",model.amount]];
    [_shengyudongjie setText:[NSString stringWithFormat:@"剩余/冻结：%ld次/%ld次",_model.nums,_model.dj_num_wrz]];
    [_chufangcishu setText:[NSString stringWithFormat:@"处方次数：%ld次",model.dj_num]];
    [_statue setText:model.state];
    
    _markView.hidden = YES;
    _markView2.hidden = YES;
    _fenqi.hidden = YES;
    _btn1.layer.cornerRadius = 3;
    _btn2.layer.cornerRadius = 3;
    if (model.fenqi_zt ==1) {
        [_btn1 setTitle:@"分期" forState:UIControlStateNormal];
        _btn1.backgroundColor = [ColorTools colorWithHexString:@"#F8F7FE"];
        [_btn1 setTitleColor:[ColorTools colorWithHexString:@"#B9B8FB"] forState:UIControlStateNormal];
    }else if (model.fenqi_zt ==2){
        [_btn1 setTitle:@"已还清" forState:UIControlStateNormal];
        _btn1W.constant = [@"已还清" stringWidthWithFont:FONT_SIZE(11)] + 10;
        _btn1.backgroundColor = [ColorTools colorWithHexString:@"#E5E5E5"];
        [_btn1 setTitleColor:kLabelText_Commen_Color_9 forState:UIControlStateNormal];
    }else{
        [_btn1 setTitle:model.ly_type_name forState:UIControlStateNormal];
        _btn1.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        _btn1W.constant = [model.ly_type_name stringWidthWithFont:FONT_SIZE(11)] + 10;
        [_btn1 setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    }
    
    if (model.is_jz == 1) {
        _btn2.hidden = NO;
        [_btn2 setTitle:@"奖赠" forState:UIControlStateNormal];
        _btn2.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        [_btn2 setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    }
    if (model.is_jz == 0) {
        _btn2.hidden = YES;
    }
}
@end
