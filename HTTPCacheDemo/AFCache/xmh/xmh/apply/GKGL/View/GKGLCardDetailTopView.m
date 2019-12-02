//
//  GKGLCardDetailTopView.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCardDetailTopView.h"
#import "NSString+Costom.h"
@interface GKGLCardDetailTopView ()
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
/** 状态 */
@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb3Top;
@property (nonatomic, copy)NSString *cardType;
@end
@implementation GKGLCardDetailTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _lb5.hidden = YES;
    _lb10.hidden = YES;
    _btn1.userInteractionEnabled = _btn2.userInteractionEnabled = NO;
    
    _btn1.backgroundColor = _btn2.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
    [_btn1 setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[ColorTools colorWithHexString:@"#FF9072"] forState:UIControlStateNormal];
    
    _btn3.layer.borderWidth = 1;
    _btn3.layer.borderColor = kColorTheme.CGColor;
    _btn3.layer.cornerRadius = 5;
    _btn3.layer.masksToBounds = YES;
    [_btn3 setTitleColor:kColorTheme forState:UIControlStateNormal];
    
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = _lb6.textColor = _lb7.textColor = _lb8.textColor = _lb9.textColor = _lb10.textColor = kColor6;
    _lb11.textColor = [ColorTools colorWithHexString:@"#FF9072"];
}
- (void)updateGKGLCardDetailTopViewParam:(NSDictionary *)param cardType:(NSString *)cardType
{
    _cardType = cardType;
    NSString * btn1Title = @"";
    NSString * btn2Title = @"";
    CGFloat btn1W = 35;
    CGFloat btn2W = 35;
    if (param[@"fenqi_zt"] == nil || [param[@"fenqi_zt"] isKindOfClass:[NSNull class]]) {
        
    }else{
        if ([param[@"fenqi_zt"] integerValue] == 0) {
            btn1Title = @"未分期";
        }
        if ([param[@"fenqi_zt"] integerValue] == 1) {
            btn1Title = @"分期";
        }
        if ([param[@"fenqi_zt"] integerValue] == 2) {
            btn1Title = @"已还清";
        }
        if ([param[@"fenqi_zt"] integerValue] == 3) {
            btn1Title = @"终止还款";
        }
    }
    btn1W = [btn1Title stringWidthWithFont:FONT_SIZE(11)];
    [_btn1 setTitle:btn1Title forState:UIControlStateNormal];
    _btn1W.constant = btn1W + 20;
    
    btn2Title = param[@"ly_type_name"];
    btn1W = [btn2Title stringWidthWithFont:FONT_SIZE(11)];
    [_btn2 setTitle:btn2Title forState:UIControlStateNormal];
    _btn2W.constant = btn2W + 20;
    
    _lb11.text = param[@"state"];
    
    if ([cardType isEqualToString:@"ticket"]) {
        _lb6.hidden = _lb8.hidden = _lb9.hidden = _lb10.hidden =  YES;
        if ([param[@"fenqi_zt"] integerValue] == 0) {
            NSString * btn1Title = param[@"ly_type_name"];
            btn1W = [btn1Title stringWidthWithFont:FONT_SIZE(11)];
            [_btn1 setTitle:btn2Title forState:UIControlStateNormal];
            _btn1W.constant = btn2W + 20;
            _btn2.hidden = YES;
        }
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"商品金额：%@",param[@"amount_a"]];
        _lb3.text = [NSString stringWithFormat:@"冻结金额：%@",param[@"dj_amount"]];
        _lb4.text = [NSString stringWithFormat:@"购买时间：%@",param[@"insert_time"]];
        _lb7.text = [NSString stringWithFormat:@"购买数量：%@",param[@"num"]];
        [_btn3 setTitle:@"消票" forState:UIControlStateNormal];
        if ([param[@"num"]integerValue] - [param[@"num1"] integerValue] ==0 || param[@"isShow"]) {
            _btn3.hidden = YES;
        }

    }else if ([cardType isEqualToString:@"bank"]) {
        _lb4.hidden = _lb5.hidden = _lb6.hidden = _lb7.hidden = _lb8.hidden = _lb9.hidden = _lb10.hidden = _lb11.hidden = YES;
        _btn1.hidden = _btn2.hidden = _btn3.hidden = YES;
        
        _lb1.text = [NSString stringWithFormat:@"账户余额：%@",param[@"money"]];
        _lb2.text = [NSString stringWithFormat:@"冻结金额：%@",param[@"dj_amount"]];
        _lb3.text = [NSString stringWithFormat:@"创建时间：%@",param[@"insert_time"]];
        _lb2.font = FONT_SIZE(13);
        _lb2.textColor = kColor3;
        _lb3Top.constant = 10;
    }else if ([cardType isEqualToString:@"goods"]) {
        _lb6.hidden = _lb9.hidden = YES;
        [_btn3 setTitle:@"终止服务" forState:UIControlStateNormal];
        
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"商品金额：%@",param[@"amount_a"]];
        _lb3.text = [NSString stringWithFormat:@"冻结金额：%@",param[@"dj_amount"]];
        _lb4.text = [NSString stringWithFormat:@"购买时间：%@",param[@"insert_time"]];
        _lb7.text = [NSString stringWithFormat:@"购买数量：%@%@",param[@"buy_num"],param[@"unit"]];
        _lb8.text = [NSString stringWithFormat:@"剩余次数：%@",param[@"shengyu_cishu"]];
        if ([param[@"shengyu_cishu"] integerValue] ==0 || param[@"isShow"]) {
            _btn3.hidden = YES;
        }
        if ([param[@"fenqi_zt"] integerValue] == 0) {
            NSString * btn1Title = param[@"ly_type_name"];
            btn1W = [btn1Title stringWidthWithFont:FONT_SIZE(11)];
            [_btn1 setTitle:btn2Title forState:UIControlStateNormal];
            _btn1W.constant = btn2W + 20;
            _btn2.hidden = YES;
        }
    }else if ([cardType isEqualToString:@"pro"]) {
        _lb6.hidden = _lb10.hidden = _btn3.hidden = YES;
        _lb5.hidden = NO;
        if ([param[@"fenqi_zt"] integerValue] == 0) {
            NSString * btn1Title = param[@"ly_type_name"];
            btn1W = [btn1Title stringWidthWithFont:FONT_SIZE(11)];
            [_btn1 setTitle:btn2Title forState:UIControlStateNormal];
            _btn1W.constant = btn2W + 20;
            _btn2.hidden = YES;
        }
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"商品金额：%@",param[@"amount_a"]];
        _lb3.text = [NSString stringWithFormat:@"冻结金额：%@",param[@"dj_amount_wrz"]];
        _lb4.text = [NSString stringWithFormat:@"处方金额：%@",param[@"dj_amount"]];
        _lb5.text = [NSString stringWithFormat:@"购买时间：%@",param[@"insert_time"]];
        _lb7.text = [NSString stringWithFormat:@"余额：%@",param[@"amount"]];
        _lb8.text = [NSString stringWithFormat:@"剩余/冻结：%@/%@",param[@"nums"],param[@"dj_num_wrz"]];
        _lb9.text = [NSString stringWithFormat:@"处方次数：%@",param[@"dj_num"]];
    }else if ([cardType isEqualToString:@"card_time"]) {
        _lb6.hidden = _lb8.hidden =  _lb9.hidden = _btn3.hidden = YES;
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"商品金额：%@",param[@"amount_p"]];
        _lb3.text = [NSString stringWithFormat:@"冻结金额：%@",param[@"dj_amount"]];
        _lb4.text = [NSString stringWithFormat:@"购买时间：%@",param[@"insert_time"]];
        _lb7.text = [NSString stringWithFormat:@"消耗金额：%@",param[@"serv_price"]];
        if ([param[@"fenqi_zt"] integerValue] == 0) {
            NSString * btn1Title = param[@"ly_type_name"];
            btn1W = [btn1Title stringWidthWithFont:FONT_SIZE(11)];
            [_btn1 setTitle:btn2Title forState:UIControlStateNormal];
            _btn1W.constant = btn2W + 20;
            _btn2.hidden = YES;
        }
    }else if ([cardType isEqualToString:@"card_num"]) {
        _lb6.hidden = _lb10.hidden = _btn3.hidden = YES;
        _lb5.hidden = NO;
        if ([param[@"fenqi_zt"] integerValue] == 0) {
            NSString * btn1Title = param[@"ly_type_name"];
            btn1W = [btn1Title stringWidthWithFont:FONT_SIZE(11)];
            [_btn1 setTitle:btn2Title forState:UIControlStateNormal];
            _btn1W.constant = btn2W + 20;
            _btn2.hidden = YES;
        }
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"商品金额：%@",param[@"amount_a"]];
        _lb3.text = [NSString stringWithFormat:@"冻结金额：%@",param[@"dj_amount"]];
        _lb4.text = [NSString stringWithFormat:@"处方金额：%@",param[@"pres_money"]];
        _lb5.text = [NSString stringWithFormat:@"购买时间：%@",param[@"insert_time"]];
        _lb7.text = [NSString stringWithFormat:@"余额：%@",param[@"amount_yue"]];
        _lb8.text = [NSString stringWithFormat:@"剩余/冻结：%@/%@",param[@"num"],param[@"sales_num"]];
        _lb9.text = [NSString stringWithFormat:@"处方次数：%@",param[@"dj_num"]];
    }else if ([cardType isEqualToString:@"stored_card"]) {
        _lb6.hidden = _lb9.hidden = _btn3.hidden = YES;
        _lb1.text = param[@"stored_card_name"];
        _lb2.text = [NSString stringWithFormat:@"商品金额：%@",param[@"stored_card_price"]];
        _lb3.text = [NSString stringWithFormat:@"处方金额：%@",param[@"dj_amount"]];
        _lb4.text = [NSString stringWithFormat:@"购买时间：%@",param[@"insert_time"]];
        _lb7.text = [NSString stringWithFormat:@"余额：%@",param[@"money"]];
        _lb8.text = [NSString stringWithFormat:@"冻结金额：%@",param[@"dj_amount_wrz"]];
        _btn2.hidden = YES;
        btn1Title = param[@"ly_type_name"];
        btn1W = [btn1Title stringWidthWithFont:FONT_SIZE(11)];
        [_btn1 setTitle:btn1Title forState:UIControlStateNormal];
        _btn1W.constant = btn2W + 20;
    }else{}
    /** 奖赠 */
    if (![cardType isEqualToString:@"bank"]) {
        if ([param.allKeys containsObject:@"is_jz"]) {
            if ([param[@"is_jz"] integerValue]==1) {
                NSString * btn2Title = @"奖赠";
                btn2W = [btn2Title stringWidthWithFont:FONT_SIZE(11)];
                [_btn2 setTitle:btn2Title forState:UIControlStateNormal];
                _btn2W.constant = btn2W + 20;
                _btn2.hidden = NO;
            }
        }
    }
}
- (IBAction)tapDown:(id)sender
{
    if ([_cardType isEqualToString:@"ticket"]) {
        if (_GKGLCardDetailTopViewCancelTicketBlock) {
            _GKGLCardDetailTopViewCancelTicketBlock();
        }
    }else if ([_cardType isEqualToString:@"goods"]){
        if (_GKGLCardDetailTopViewEndServiceBlock) {
            _GKGLCardDetailTopViewEndServiceBlock();
        }
    }else{}
}
@end
