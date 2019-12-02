//
//  MzzChuZhiCardCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzChuZhiCardCell.h"
#import "LolMarkView.h"
#import <YYWebImage/YYWebImage.h>
@interface MzzChuZhiCardCell ()
@property (weak, nonatomic) IBOutlet UILabel *cardName;
@property (weak, nonatomic) IBOutlet UILabel *goumaishijian;
@property (weak, nonatomic) IBOutlet UILabel *shangpinjine;
@property (weak, nonatomic) IBOutlet UILabel *chufangjine;
@property (weak, nonatomic) IBOutlet UILabel *yue;
@property (weak, nonatomic) IBOutlet UILabel *dongjiejine;
@property (weak, nonatomic) IBOutlet UILabel *statue;
@property (weak, nonatomic) IBOutlet UIImageView *fenqi;
@property (weak, nonatomic) IBOutlet LolMarkView *markView;
@property (weak, nonatomic) IBOutlet LolMarkView *markView2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1W;

@end

@implementation MzzChuZhiCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStoredModel:(MzzStored_CardModel *)storedModel{
    _storedModel = storedModel;
    [_cardName setText:storedModel.stored_card_name?storedModel.stored_card_name:@"无" ];
    [_markView lolMarkViewImageName:@"bookbiaoqian" Title:storedModel.ly_type_name];
    if (storedModel.is_jz ==1) {
        [_markView2 lolMarkViewImageName:@"bookbiaoqian" Title:@"奖赠"];
    }else {
        _markView2.hidden = YES;
    }
    
    [_goumaishijian setText:[@"购买时间：" stringByAppendingString:storedModel.insert_time]];
    if (storedModel.stored_card_price) {
        [_shangpinjine setText:[@"商品金额：" stringByAppendingString:storedModel.stored_card_price]];
    }else{
         [_shangpinjine setText:@"商品金额："];
    }
    
    [_chufangjine setText: [@"处方金额：" stringByAppendingString:[NSString stringWithFormat:@"%ld",storedModel.dj_amount]]];
    [_yue setText:[@"余额：" stringByAppendingString:storedModel.money]];
    [_dongjiejine setText:[@"冻结金额：" stringByAppendingString:storedModel.dj_amount_wrz]];
    [_statue setText:storedModel.state];

    
    
    
    _markView.hidden = YES;
    _markView2.hidden = YES;
    _fenqi.hidden = YES;
    _btn1.layer.cornerRadius = 3;
    _btn2.layer.cornerRadius = 3;
    if (storedModel.fenqi_zt ==1) {
        [_btn1 setTitle:@"分期" forState:UIControlStateNormal];
        _btn1.backgroundColor = [ColorTools colorWithHexString:@"#F8F7FE"];
        [_btn1 setTitleColor:[ColorTools colorWithHexString:@"#B9B8FB"] forState:UIControlStateNormal];
    }else if (storedModel.fenqi_zt ==2){
        [_btn1 setTitle:@"已还清" forState:UIControlStateNormal];
        _btn1W.constant = [@"已还清" stringWidthWithFont:FONT_SIZE(11)] + 10;
        _btn1.backgroundColor = [ColorTools colorWithHexString:@"#E5E5E5"];
        [_btn1 setTitleColor:kLabelText_Commen_Color_9 forState:UIControlStateNormal];
    }else{
        [_btn1 setTitle:storedModel.ly_type_name forState:UIControlStateNormal];
        _btn1.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        _btn1W.constant = [storedModel.ly_type_name stringWidthWithFont:FONT_SIZE(11)] + 10;
        [_btn1 setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    }
    
    if (_storedModel.is_jz == 1) {
        _btn2.hidden = NO;
        [_btn2 setTitle:@"奖赠" forState:UIControlStateNormal];
        _btn2.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        [_btn2 setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    }
    if (_storedModel.is_jz == 0) {
        _btn2.hidden = YES;
    }
    
}
@end
