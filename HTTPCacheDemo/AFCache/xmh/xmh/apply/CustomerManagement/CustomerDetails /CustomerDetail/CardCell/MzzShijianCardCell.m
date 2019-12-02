//
//  MzzShijianCardCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzShijianCardCell.h"
#import "LolMarkView.h"
@interface MzzShijianCardCell ()
@property (weak, nonatomic) IBOutlet UIImageView *fenqi;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *goumaishijian;
@property (weak, nonatomic) IBOutlet LolMarkView *markView;
@property (weak, nonatomic) IBOutlet LolMarkView *markView2;
@property (weak, nonatomic) IBOutlet UILabel *statue;

@property (weak, nonatomic) IBOutlet UILabel *youxiaoqi;
@property (weak, nonatomic) IBOutlet UILabel *xiaohaoyue;
@property (weak, nonatomic) IBOutlet UILabel *dongjiejine;
@property (weak, nonatomic) IBOutlet UILabel *shangpinjine;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1W;

@end

@implementation MzzShijianCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MzzCard_TimeModel *)model{
    _model = model;
    if (_model.fenqi_zt ==2) {
        [_fenqi setImage:[UIImage imageNamed:@"yihuanqing"]];
    }else if (model.fenqi_zt ==1){
        [_fenqi setImage:[UIImage imageNamed:@"fenqi"]];
    }else{
        [_fenqi setImage:nil];;
    }
    [_name setText:model.name?model.name:@"无" ];
    [_markView lolMarkViewImageName:@"bookbiaoqian" Title:model.ly_type_name];
    if (model.is_jz ==1) {
        [_markView2 lolMarkViewImageName:@"bookbiaoqian" Title:@"奖赠"];
    }else {
        _markView2.hidden = YES;
    }
    [_goumaishijian setText:[@"购买时间：" stringByAppendingString:model.insert_time?model.insert_time:@""]];
    [_youxiaoqi setText:[@"有效期：" stringByAppendingString:[NSString stringWithFormat:@"%ld天",model.day]]];
    [_xiaohaoyue setText: [@"消耗金额：" stringByAppendingString:[NSString stringWithFormat:@"%ld元",model.serv_price]]];
    [_dongjiejine setText:[NSString stringWithFormat:@"冻结金额：%@元",model.dj_amount]];
    [_shangpinjine setText:[NSString stringWithFormat:@"商品金额：%@元",model.amount_p]];
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
