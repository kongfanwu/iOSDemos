//
//  MzzChanpinCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzChanpinCell.h"
#import "LolMarkView.h"
#import "MzzCustomerRequest.h"
@interface MzzChanpinCell ()
@property (weak, nonatomic) IBOutlet UIImageView *fenqi;
@property (weak, nonatomic) IBOutlet UIButton *zhongzhifuwuBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *goumaishijian;
@property (weak, nonatomic) IBOutlet UILabel *goumaishuliang;
@property (weak, nonatomic) IBOutlet UILabel *shangpinjine;
@property (weak, nonatomic) IBOutlet UILabel *shengyucishu;
@property (weak, nonatomic) IBOutlet UILabel *dongjiejine;
@property (weak, nonatomic) IBOutlet UILabel *statue;
@property (weak, nonatomic) IBOutlet LolMarkView *markView;
@property (weak, nonatomic) IBOutlet LolMarkView *markView2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1W;

@end

@implementation MzzChanpinCell
- (IBAction)zhongzhifuwu:(id)sender {
    [[[MzzHud alloc] initWithTitle:@"平台提醒" message:@"你确定要终止服务吗" leftButtonTitle:@"取消" rightButtonTitle:@"确定" click:^(NSInteger index) {
        if (index ==1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"user_id"] = _user_id;
            params[@"goods_id"] = [NSString stringWithFormat:@"%ld",_model.goods_id];
            [MzzCustomerRequest requestStopGoodParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MzzGoodsModel *)model{
    _model = model;
    if (_model.fenqi_zt ==2) {
        [_fenqi setImage:[UIImage imageNamed:@"yihuanqing"]];
    }else if (model.fenqi_zt ==1){
        [_fenqi setImage:[UIImage imageNamed:@"fenqi"]];
    }else{
        [_fenqi setImage:nil];
    }
    [_name setText:model.name?model.name:@"无"];
    [_markView lolMarkViewImageName:@"bookbiaoqian" Title:model.ly_type_name];
    if (model.is_jz ==1) {
        [_markView2 lolMarkViewImageName:@"bookbiaoqian" Title:@"奖赠"];
    }else {
        _markView2.hidden = YES;
    }
    if (model.shengyu_cishu <= 0  || model.is_end == 1 || [model.is_serv isEqualToString:@"0"]) {
        _zhongzhifuwuBtn.hidden = YES;
    }else{
        _zhongzhifuwuBtn.hidden = NO;
    }
    [_goumaishijian setText:[@"购买时间：" stringByAppendingString:model.insert_time]];
    [_goumaishuliang setText:[@"购买数量：" stringByAppendingString:[NSString stringWithFormat:@"%ld",model.buy_num]]];
    [_shangpinjine setText: [@"商品金额：" stringByAppendingString:[NSString stringWithFormat:@"%@元",model.amount_a]]];
    [_shengyucishu setText:[@"剩余次数：" stringByAppendingString:[NSString stringWithFormat:@"%ld次",model.shengyu_cishu]]];
    [_dongjiejine setText:[@"冻结金额：" stringByAppendingString:[NSString stringWithFormat:@"%.2f元",model.dj_amount]]];
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
