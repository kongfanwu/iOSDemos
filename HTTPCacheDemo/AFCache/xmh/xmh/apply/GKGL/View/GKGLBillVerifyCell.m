//
//  GKGLBillVerifyCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLBillVerifyCell.h"

@interface GKGLBillVerifyCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIButton *btnModify;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;

@end
@implementation GKGLBillVerifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnDel.layer.cornerRadius = _btnModify.layer.cornerRadius = 5;
    _btnModify.layer.masksToBounds = _btnDel.layer.masksToBounds = YES;
    _btnModify.layer.borderColor = _btnDel.layer.borderColor = kColorTheme.CGColor;
    _btnModify.layer.borderWidth = _btnDel.layer.borderWidth = 1;
    [_btnModify setTitle:@"修改" forState:UIControlStateNormal];
    [_btnDel setTitle:@"删除" forState:UIControlStateNormal];
    [_btnModify setTitleColor:kColorTheme forState:UIControlStateNormal];
    [_btnDel setTitleColor:kColorTheme forState:UIControlStateNormal];
}
- (void)updateCellParam:(NSDictionary *)param type:(NSString *)type
{
    if ([type isEqualToString:@"stored_card"]) {
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"购买时间：%@",param[@"pay_time"]];
        _lb3.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"money"]];
        _lb4.text = [NSString stringWithFormat:@"余额：%@元",param[@"denomination"]];
        _lb5.hidden = _lb6.hidden = YES;
    }else if ([type isEqualToString:@"pro"]) {
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"购买时间：%@",param[@"pay_time"]];
        _lb3.text = [NSString stringWithFormat:@"截止日期：%@",param[@"end_time"]];
        _lb4.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"amount"]];
        _lb5.text = [NSString stringWithFormat:@"购买次数：%@次",param[@"num"]];
        _lb6.text = [NSString stringWithFormat:@"剩余次数：%@次",param[@"sheng_num"]];
    }else if ([type isEqualToString:@"goods"]) {
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"购买时间：%@",param[@"pay_time"]];
        _lb3.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"amount"]];
        _lb4.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"amount"]];
        _lb5.text = [NSString stringWithFormat:@"购买次数：%@次",param[@"num"]];
        _lb6.text = [NSString stringWithFormat:@"剩余次数：%@次",param[@"sheng_num"]];
    }else if ([type isEqualToString:@"card_num"]) {
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"购买时间：%@",param[@"pay_time"]];
        _lb3.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"amount"]];
        _lb4.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"amount"]];
        _lb5.text = [NSString stringWithFormat:@"购买次数：%@次",param[@"num"]];
        _lb6.text = [NSString stringWithFormat:@"剩余次数：%@次",param[@"sheng_num"]];
    }else if ([type isEqualToString:@"card_time"]) {
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"购买时间：%@",param[@"pay_time"]];
        _lb3.text = [NSString stringWithFormat:@"截止日期：%@",param[@"end_time"]];
        _lb4.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"amount"]];
        _lb5.hidden = _lb6.hidden = YES;
    }else if ([type isEqualToString:@"ticket"]) {
        _lb1.text = param[@"name"];
        _lb2.text = [NSString stringWithFormat:@"购买时间：%@",param[@"pay_time"]];
        _lb3.text = [NSString stringWithFormat:@"购买金额：%@元",param[@"amount"]];
        _lb3.hidden = _lb5.hidden = _lb6.hidden = YES;
    }
}
@end
