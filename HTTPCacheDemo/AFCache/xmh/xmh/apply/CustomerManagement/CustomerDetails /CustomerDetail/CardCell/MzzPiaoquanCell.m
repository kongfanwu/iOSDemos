//
//  MzzPiaoquanCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPiaoquanCell.h"
#import "LolMarkView.h"
#import "MzzCustomerRequest.h"
@interface MzzPiaoquanCell ()
@property (weak, nonatomic) IBOutlet UIImageView *fenqi;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet LolMarkView *markView;
@property (weak, nonatomic) IBOutlet LolMarkView *markView2;
@property (weak, nonatomic) IBOutlet UILabel *goumaishijian;
@property (weak, nonatomic) IBOutlet UILabel *goumaishuliang;
@property (weak, nonatomic) IBOutlet UILabel *shangpinjine;
@property (weak, nonatomic) IBOutlet UILabel *dongjiejine;
@property (weak, nonatomic) IBOutlet UILabel *statue;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1W;
@property (weak, nonatomic) IBOutlet UIButton *btnXiaoPiao;

@end

@implementation MzzPiaoquanCell
- (IBAction)xiaopiao:(id)sender {
    [[[MzzHud alloc] initWithTitle:@"平台提醒" message:@"你确定要消票吗" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
        if (index ==1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"user_id"] = _user_id;
            params[@"ticket_id"] = [NSString stringWithFormat:@"%ld",_model.ID];
            [MzzCustomerRequest requestStopTicketParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if (self.reFresh) {
                        self.reFresh();
                    }
                }else{
                    
                }
            }];
        }
    }]show];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnXiaoPiao.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MzzTicketModel *)model{
    _model = model;
    if (_model.fenqi_zt ==2) {
        [_fenqi setImage:[UIImage imageNamed:@"yihuanqing"]];
    }else if (model.fenqi_zt ==1){
        [_fenqi setImage:[UIImage imageNamed:@"fenqi"]];
    }else{
        [_fenqi setImage:nil];
    }
    [_name setText:model.name ];
    [_markView lolMarkViewImageName:@"bookbiaoqian" Title:model.ly_type_name];
    if (model.is_jz ==1) {
        [_markView2 lolMarkViewImageName:@"bookbiaoqian" Title:@"奖赠"];
    }else {
        _markView2.hidden = YES;
    }
    [_goumaishijian setText:[@"购买时间：" stringByAppendingString:model.insert_time]];
    [_goumaishuliang setText:[@"购买数量：" stringByAppendingString:[NSString stringWithFormat:@"%ld张",model.num]]];
    [_shangpinjine setText: [@"商品金额：" stringByAppendingString:[NSString stringWithFormat:@"%ld元",model.amount_a]]];
    [_dongjiejine setText:[@"冻结金额：" stringByAppendingString:[NSString stringWithFormat:@"%@元",model.dj_amount]]];
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
- (void)updateCellModel:(MzzTicketCouponModel *)model
{
    NSString * text = @"";
    if (model.type == 3) {
        text = @"现金券";
    }else if (model.type == 4){
        text = @"折扣券";
    }else if (model.type == 5){
        text = @"礼品券";
    }
    NSString * textEdu = @"";
    if (model.type == 3) {
        textEdu = [NSString stringWithFormat:@"%@-%@元",model.fulfill,model.price];
    }else if (model.type == 4){
        textEdu = [NSString stringWithFormat:@"%@折",model.discount];
    }else if (model.type == 5){
        textEdu = model.name;
    }
    [_goumaishijian setText: [NSString stringWithFormat:@"优惠额度：%@",textEdu]];
    [_goumaishuliang setText:[@"发行品牌：" stringByAppendingString:[NSString stringWithFormat:@"%@",model.join_name]]];
    
    _name.text = text;

    [_shangpinjine setText: [NSString stringWithFormat:@"有效期：%@-%@",model.startTime,model.endTime]];
//    [_dongjiejine setText:[@"限制使用金额：" stringByAppendingString:[NSString stringWithFormat:@"%@元",model.fulfill]]];
    _dongjiejine.hidden = YES;
    _btn1.hidden = YES;
    _btn2.hidden = YES;
    _btnXiaoPiao.hidden = YES;
    if (model.jh_zt == 0) {
        _statue.text = @"待激活";
    }else{
        if (model.status == 1) {
            _statue.text = @"未使用";
        }else if (model.status == 2){
            _statue.text  = @"已用完";
        }else if (model.status == 5 ){
            _statue.text = @"已过期";
        }
    }
}
@end
