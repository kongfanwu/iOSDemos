//
//  RefundCommonCell.m
//  xmh
//
//  Created by ald_ios on 2018/11/12.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundCommonCell.h"
#import "RefundListModel.h"
@interface RefundCommonCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;

@property (weak, nonatomic) IBOutlet UIButton *btnDrop;
@property (weak, nonatomic) IBOutlet UIButton *btnJian;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnAddGWC;
@property (weak, nonatomic) IBOutlet UITextField *tfInput;
@property (weak, nonatomic) IBOutlet UILabel *lbUnit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb3Top;

@end
@implementation RefundCommonCell
{
    RefundModel * _rufundModel;
    /** 次数 */
    NSInteger  _num;
    /** 输入的退款金额 */
    NSString * _inputValue;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _tfInput.delegate = self;
    _num = 0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (void)updateRefundCommonCellModel:(RefundModel *)model
{
    _rufundModel = model;
    _btnDrop.selected = _rufundModel.showed;
    /** 判断是否展开 */
    if (model.showed) {
        _lb3.hidden = NO;
        _lb4.hidden = NO;
        _lb5.hidden = NO;
        _lb6.hidden = NO;
        _lb7.hidden = NO;
        
        _btnAll.hidden = NO;
        _btnAddGWC.hidden = NO;
        _btnAdd.hidden = NO;
        _btnJian.hidden = NO;
        _lbNum.hidden = NO;
        _lbUnit.hidden = NO;
        _tfInput.hidden = NO;
    }else{
        _lb3.hidden = YES;
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        
        _btnAll.hidden = YES;
        _btnAddGWC.hidden = YES;
        _btnAdd.hidden = YES;
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
        
        _lbUnit.hidden = YES;
        _tfInput.hidden = YES;
    }
    /** 根据类型判断展开时保留数据量 */
    
    /** 项目 人选卡 产品 保留 lb1 lb2 lb3*/
    if ([model.type isEqualToString:@"pro"]||[model.type isEqualToString:@"card_num"]) {
        _lb1.text = model.name;
        _lb2.text = [NSString stringWithFormat:@"剩余金额：%@",model.money];
        _lb3.text = [NSString stringWithFormat:@"剩余次数：%@",model.num];
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lbUnit.hidden = YES;
        _tfInput.hidden = YES;
        
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
    }
    if ([model.type isEqualToString:@"goods"]) {
        _lb1.text = model.name;
        _lb2.text = [NSString stringWithFormat:@"剩余金额：%@",model.money];
        _lb3.text = [NSString stringWithFormat:@"剩余次数：%@",model.num];
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lbUnit.hidden = YES;
        _tfInput.hidden = YES;
        
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
        _btnAdd.hidden = YES;
        _btnAll.hidden = YES;
    }
    /** 时间卡 保留lb1 lb2 lb3 lb4 */
    if ([model.type isEqualToString:@"card_time"]) {
        _lb1.text = model.name;
        _lb2.text = [NSString stringWithFormat:@"购买金额：%@",model.money];
        _lb3.text = [NSString stringWithFormat:@"消耗金额：%@",model.xiaohao];
        _lb4.text = [NSString stringWithFormat:@"截止时间：%@",model.end_time];
        
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lbUnit.hidden = YES;
        _tfInput.hidden = YES;
        _btnAll.hidden = YES;
    }
    /** 票券 保留 lb1 lb2 lb3 */
    if ([model.type isEqualToString:@"ticket"]) {
        _lb1.text = model.name;
        _lb2.text = [NSString stringWithFormat:@"票券价格：%@",model.money];
        _lb3.text = model.expiry;
        
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _lbUnit.hidden = YES;
        _tfInput.hidden = YES;
        
        _btnAll.hidden = YES;
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
        _btnAdd.hidden = YES;
    }
    /** 定金订单 票券 保留 lb1 lb2 lb3 lb4 lb5 lb6 lb7*/
    if ([model.type isEqualToString:@"sales"]) {
        _lb1.text = [NSString stringWithFormat:@"订单编号：%@",model.ordernum];
        _lb2.text = [NSString stringWithFormat:@"冻结金额：%@",model.tk_amount];
        _lb3.text = [NSString stringWithFormat:@"开单人：%@",model.inper];
        _lb4.text = [NSString stringWithFormat:@"开单类型：%@",model.order_type];
        _lb5.text = [NSString stringWithFormat:@"应付金额：%@",model.heji];
        _lb6.text = [NSString stringWithFormat:@"实付金额：%@",model.amount];
        _lb7.text = [NSString stringWithFormat:@"开单时间：%@",model.insert_time];
        
        _lbUnit.hidden = YES;
        _tfInput.hidden = YES;
        _btnAll.hidden = YES;
        _btnAdd.hidden = YES;
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
    }
    /** 账户 保留 lb1 lb2 lb3 */
    if ([model.type isEqualToString:@"bank"]) {
        _lb1.text = @"账户";
        _lb2.text = [NSString stringWithFormat:@"剩余金额：%@",model.money];
        _lb3.text = @"退款金额";
        _lb3Top.constant = 15;
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _btnAll.hidden = YES;
        _btnAdd.hidden = YES;
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
    }
    /** 储值卡 保留 lb1 lb2 lb3 */
    if ([model.type isEqualToString:@"stored_card"]) {
        _lb1.text = model.name;
        _lb2.text = [NSString stringWithFormat:@"剩余金额：%@",model.money];
        _lb3.text = @"退款金额";
        _lb3Top.constant = 15;
        _lb4.hidden = YES;
        _lb5.hidden = YES;
        _lb6.hidden = YES;
        _lb7.hidden = YES;
        _btnAll.hidden = YES;
        _btnAdd.hidden = YES;
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
    }

}
/** 展开按钮点击 */
- (IBAction)show:(id)sender
{
    UIButton * dropBtn = (UIButton *)sender;
    dropBtn.selected = !dropBtn.selected;
    _rufundModel.showed = !_rufundModel.showed;
    if (_RefundCommonCellShowBlock) {
        _RefundCommonCellShowBlock(_rufundModel);
    }
}
/** 全部退款按钮点击 */
- (IBAction)btnAll:(id)sender
{
    _rufundModel.paramValue = _rufundModel.money;
    if (_RefundCommonCellAllBlock) {
        _RefundCommonCellAllBlock(_rufundModel);
    }
}
/** 加入购物车按钮点击 */
- (IBAction)btnAddGWC:(id)sender
{
    [_tfInput resignFirstResponder];
    /** 1、储值卡 和账户 需要判断金额  2、其余需要判断次数*/
    if ([_rufundModel.type isEqualToString:@"bank"]||[_rufundModel.type isEqualToString:@"stored_card"]) {
        if (_inputValue.length == 0) {
            [XMHProgressHUD showOnlyText:@"请设置正确的退款金额或次数"];
        }else{
           _rufundModel.paramValue = _inputValue;
        }
        
    }else if ([_rufundModel.type isEqualToString:@"ticket"] || [_rufundModel.type isEqualToString:@"goods"]||[_rufundModel.type isEqualToString:@"sales"]){
        _rufundModel.paramValue = _rufundModel.money.length > 0 ?_rufundModel.money:_rufundModel.tk_amount;
    }else{
        /** 计算回收金额 */
        if (_num == 0) {
            [XMHProgressHUD showOnlyText:@"请设置正确的退款金额或次数"];
            return;
        }
        _rufundModel.paramValue = [NSString stringWithFormat:@"%.2f",(_rufundModel.money.floatValue / _rufundModel.num.integerValue)*_num];
    }
    [XMHProgressHUD showOnlyText:@"加入购物车成功"];
    if (_RefundCommonCellAddGWCBlock) {
        _RefundCommonCellAddGWCBlock(_rufundModel);
    }
}
/** 加号点击 */
- (IBAction)btnAdd:(id)sender
{
    _num ++;
    if (_num > _rufundModel.num.integerValue) {
        [XMHProgressHUD showOnlyText:@"请设置正确的退款金额或次数"];
        _num = _rufundModel.num.integerValue;
        /** 计算剩余次数 */
        _rufundModel.quitNum = [NSString stringWithFormat:@"%ld",_num];
        return;
    }else{
       _rufundModel.quitNum = [NSString stringWithFormat:@"%ld",_num];
    }
    
    _btnJian.hidden = NO;
    _lbNum.hidden = NO;
    _lbNum.text = [NSString stringWithFormat:@"%ld",_num];
}
/** 减号点击 */
- (IBAction)btnMinus:(id)sender
{
    _num --;
    if (_num == 0) {
        _btnJian.hidden = YES;
        _lbNum.hidden = YES;
    }
    _lbNum.text = [NSString stringWithFormat:@"%ld",_num];
}
#pragma mark ------UITextFieldDelegate------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _inputValue = textField.text;
}
@end
