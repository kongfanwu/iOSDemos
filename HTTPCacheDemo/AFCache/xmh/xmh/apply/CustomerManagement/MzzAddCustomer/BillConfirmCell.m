//
//  BillConfirmCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BillConfirmCell.h"

@implementation BillConfirmCell{
    NSInteger _section;
    NSMutableDictionary *_dic;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _btnChange.layer.cornerRadius = 5;
    _btnChange.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
    _btnDel.layer.cornerRadius = 5;
    _btnDel.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
}
//储值卡
- (void)freshBillConfirmCell0:(NSMutableDictionary *)dic withsection:(NSInteger)section{
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买日期：";
    _lb2.text = @"购买金额：";
    _lb3.text = @"余额：";
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    
    _lb6.text = dic[@"pay_time"];
    _lb7.text = [NSString stringWithFormat:@"%@ 元",dic[@"denomination"]];
    _lb8.text = [NSString stringWithFormat:@"%@ 元",dic[@"money"]];
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    
    if ([dic[@"state"] isEqualToString:@"1"]) {
        _btn1.selected = YES;
    } else {
        _btn1.selected = NO;
    }
    _section = section;
    _dic = dic;
}
//时间卡
- (void)freshBillConfirmCell1:(NSMutableDictionary *)dic withsection:(NSInteger)section{
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买日期：";
    _lb2.text = @"截止日期：";
    _lb3.text = @"购买金额：";
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    
    _lb6.text = dic[@"pay_time"];
    _lb7.text = dic[@"end_time"];
    _lb8.text = [NSString stringWithFormat:@"%@ 元",dic[@"amount"]];
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    
    if ([dic[@"state"] isEqualToString:@"1"]) {
        _btn1.selected = YES;
    } else {
        _btn1.selected = NO;
    }
    _section = section;
    _dic = dic;
}
//任选卡
- (void)freshBillConfirmCell2:(NSMutableDictionary *)dic withsection:(NSInteger)section{
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买时间：";
    _lb2.text = @"购买金额：";
    _lb3.text = @"购买次数：";
    _lb4.text = @"剩余次数：";
    _lb5.hidden = YES;
    
    _lb6.text = dic[@"pay_time"];
    _lb7.text = [NSString stringWithFormat:@"%@ 元",dic[@"amount"]];
    _lb8.text = [NSString stringWithFormat:@"%@ ",dic[@"num"]];
    _lb9.text = [NSString stringWithFormat:@"%@ ",dic[@"sheng_num"]];
    _lb10.hidden = YES;
    
    if ([dic[@"state"] isEqualToString:@"1"]) {
        _btn1.selected = YES;
    } else {
        _btn1.selected = NO;
    }
    _section = section;
    _dic = dic;
}
//特惠卡、项目
- (void)freshBillConfirmCell3:(NSMutableDictionary *)dic withsection:(NSInteger)section{
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买时间：";
    _lb2.text = @"余额：";
    _lb3.text = @"购买次数：";
    _lb4.text = @"剩余次数：";
    _lb5.hidden = YES;
    _lb6.text = dic[@"pay_time"];
    _lb7.text = [NSString stringWithFormat:@"%@ 元",dic[@"amount"]];
    _lb8.text = [NSString stringWithFormat:@"%@ 次",dic[@"num"]];
    _lb9.text = [NSString stringWithFormat:@"%@ ",dic[@"sheng_num"]];
    _lb10.hidden = YES;

    if ([dic[@"state"] isEqualToString:@"1"]) {
        _btn1.selected = YES;
    } else {
        _btn1.selected = NO;
    }
    _section = section;
    _dic = dic;
}
//产品
- (void)freshBillConfirmCell4:(NSMutableDictionary *)dic withsection:(NSInteger)section{
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买日期：";
    _lb2.text = @"购买金额：";
    _lb3.text = @"余额：";
    _lb4.text = @"购买次数：";
    _lb5.text = @"剩余次数：";
    
    _lb6.text = dic[@"pay_time"];
    _lb7.text = [NSString stringWithFormat:@"%@ 元",dic[@"amount_a"]];
    _lb8.text = [NSString stringWithFormat:@"%@ 元",dic[@"amount"]];
    _lb9.text = [NSString stringWithFormat:@"%@ ",dic[@"num"]];
    _lb10.text = [NSString stringWithFormat:@"%@ ",dic[@"sheng_num"]];

    if ([dic[@"state"] isEqualToString:@"1"]) {
        _btn1.selected = YES;
    } else {
        _btn1.selected = NO;
    }
    _section = section;
    _dic = dic;
}
//票券
- (void)freshBillConfirmCell5:(NSMutableDictionary *)dic withsection:(NSInteger)section{
    _lbTitle.text = dic[@"name"];
    _lb1.text = @"购买时间：";
    _lb2.text = @"购买金额：";
    _lb3.hidden = YES;
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    
    _lb6.text = dic[@"pay_time"];
    _lb7.text = [NSString stringWithFormat:@"%@ 元",dic[@"money"]];
    _lb8.hidden = YES;
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    
    if ([dic[@"state"] isEqualToString:@"1"]) {
        _btn1.selected = YES;
    } else {
        _btn1.selected = NO;
    }
    _section = section;
    _dic = dic;
}
- (IBAction)btn1Event:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSString *state = @"0";
    BOOL _boolState = NO;
    if (sender.selected) {
        state = @"1";
        _boolState = YES;
    } else {
        state = @"0";
        _boolState = NO;
    }
    if (_btnBillConfirmCellBlock) {
        _btnBillConfirmCellBlock(state,_section);
    }
}
- (IBAction)btnChangeEvent:(UIButton *)sender {
    if (_btnBillConfirmCellModifyBlock) {
        _btnBillConfirmCellModifyBlock(_dic,_section);
    }
}
- (IBAction)btnDelEvent:(id)sender {
    if (_btnBillConfirmCellDelBlock) {
        _btnBillConfirmCellDelBlock(_dic,_section);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
