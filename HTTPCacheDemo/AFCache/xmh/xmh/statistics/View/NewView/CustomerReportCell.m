//
//  CustomerReportCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerReportCell.h"
#import "TJCustomerListModel.h"
#import "TJCustomerTopModel.h"
#import "TJCustomerActiveListModel.h"
#import "TJCustomerActiveDetailModel.h"
#import "TJExpendListModel.h"
#import "TJCashListModel.h"
@interface CustomerReportCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbStore;
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb1Top;
@end
@implementation CustomerReportCell
{
    TJCustomerModel * _customerModel;
    TJCustomerTopModel * _customerTopModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
//- (void)updateCustomerReportCellTopModel:(TJCustomerTopModel *)model
//{
//    _customerTopModel = model;
//}
- (void)updateCustomerReportCellModel:(TJCustomerModel *)model
{
    _lbName.text = model.name;
    _lbStore.text = model.store_name;
    _lb1.text = [NSString stringWithFormat:@"销售业绩：%@元",model.xiaoshouyeji];
    _lb2.text = [NSString stringWithFormat:@"消耗业绩：%@元",model.xiaohaoyeji];
    _lb3.text = [NSString stringWithFormat:@"接待客次：%@次",model.keci];
    _lb4.text = [NSString stringWithFormat:@"成交顾客数：%@人",model.chengjiao];
    _lb5.text = [NSString stringWithFormat:@"消耗项目数：%@个",model.shicaoxiangmushu];
    _lb6.text = model.bfb1;
    _lb7.text = model.bfb2;
    _lb8.text = model.bfb3;
    _lb9.text = model.bfb4;
    _lb10.text = model.bfb5;
    
    if (model.type.integerValue == 1) {
        _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
        _lb6.textColor = [ColorTools colorWithHexString:@"#FF0000"];
        
    }
    if (model.type.integerValue == 2) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
        _lb7.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 3) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
        _lb8.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 4) {
        _lb4.textColor = [ColorTools colorWithHexString:@"#FF0000"];
        _lb9.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 5) {
        _lb5.textColor = [ColorTools colorWithHexString:@"#FF0000"];
        _lb10.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
}
- (void)updateCustomerReportCellCustomerActiveModel:(TJCustomerActiveModel *)model
{
    _lbName.text = model.name;
    _lbStore.text = model.store_name;
    
    _lb1.text = [NSString stringWithFormat:@"消费金额：%@元",model.xiaofeijine];
    _lb2.text = [NSString stringWithFormat:@"耗卡单价：%@元",model.haokadanjia];
    _lb3.text = [NSString stringWithFormat:@"消费次数：%@个",model.xiaofeicishu];
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    
    _lb6.text = [NSString stringWithFormat:@"消耗金额：%@元",model.xiaohaojine];
    _lb7.text = [NSString stringWithFormat:@"消耗项目数：%@个",model.xiangmushu];
    _lb8.text = [NSString stringWithFormat:@"到店次数：%@个",model.daodiancishu];
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    if (model.type.integerValue == 1) {
        _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 2) {
        _lb6.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 3) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 4) {
        _lb7.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 5) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 6) {
        _lb8.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    
}
- (void)updateCustomerReportCellCustomerActiveDetailModel:(TJCustomerActiveDetailModel *)model row:(NSInteger)row
{
    _lb1Top.constant = 5;
    _lbStore.hidden = YES;
    _lb3.hidden = YES;
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    _lb7.hidden = YES;
    _lb8.hidden = YES;
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    if (row == 0) {
        _lbName.text = @"消费情况";
        _lb1.text = [NSString stringWithFormat:@"消费金额：%@元",model.xiaofeijine];
        _lb2.text = [NSString stringWithFormat:@"消费次数：%@个",model.xiaofeicishu];
        _lb6.text = [NSString stringWithFormat:@"平均间隔：%@天",model.pingjunjiange];
        
    }
    if (row == 1) {
        _lbName.text = @"消耗情况";
        _lb7.hidden = NO;
        
        _lb1.text = [NSString stringWithFormat:@"消耗金额：%@元",model.xiaohaojine];
        _lb2.text = [NSString stringWithFormat:@"耗卡单价：%@元",model.haokadanjia];
        _lb6.text = [NSString stringWithFormat:@"消耗项目数：%@个",model.xiangmushu];
        _lb7.text = [NSString stringWithFormat:@"到店次数：%@次",model.daodiancishu];
    }
    if (row == 2) {
        _lbName.text = @"预约情况";
        _lb7.hidden = NO;
        
        _lb1.text = [NSString stringWithFormat:@"预约次数：%@次",model.yuyuecishu];
        _lb2.text = [NSString stringWithFormat:@"按时到店：%@次",model.anshidaodian];
        _lb6.text = [NSString stringWithFormat:@"修改预约：%@次",model.xiugaiyuyue];
        _lb7.text = [NSString stringWithFormat:@"未按时到店：%@次",model.weianshidaodian];
    }
    if (row == 3) {
        _lbName.text = @"处方规划情况";
        _lb3.hidden = NO;
        _lb7.hidden = NO;
        _lb8.hidden = NO;
        
        _lb1.text = [NSString stringWithFormat:@"规划总处方数：%@个",model.zongchufangshu];
        _lb2.text = [NSString stringWithFormat:@"处方执行次数：%@次",model.zhixingcishu];
        _lb3.text = [NSString stringWithFormat:@"待执行次数：%@次",model.daizhixingcishu];
        _lb6.text = [NSString stringWithFormat:@"规划总金额：%@元",model.zongjine];
        _lb7.text = [NSString stringWithFormat:@"处方消耗金额：%@元",model.chufangxiaohaojine];
        _lb8.text = [NSString stringWithFormat:@"待消耗金额：%@元",model.daixiaohaojine];
        
    }
}
- (void)updateCustomerReportCellExpendModel:(TJExpendModel *)model
{
    _lbName.text = model.name;
    _lbStore.hidden = YES;
    _lb1.text = [NSString stringWithFormat:@"总负债金额：%@元",model.zongfuzhai];
    _lb2.text = [NSString stringWithFormat:@"疗程卡负债金额：%@元",model.liaochengkafuzhaijine];
    _lb3.text = [NSString stringWithFormat:@"储值卡负债金额：%@元",model.chuzhikafuzhaijine];
    _lb4.text = [NSString stringWithFormat:@"消耗金额：%@元",model.xiaohaojine];
    _lb5.hidden = YES;
    
    _lb6.text = [NSString stringWithFormat:@"规划消耗金额：%@元",model.guihuaxiaohao];
    _lb7.text = [NSString stringWithFormat:@"疗程卡负债次数：%@次",model.liaochengkafuzhaicishu];
    _lb8.text = [NSString stringWithFormat:@"储值卡负债张数：%@张",model.chuzhikafuzhaizhangshu];
    _lb9.text = [NSString stringWithFormat:@"消耗占比：%@%@",model.bfb,@"%"];
    _lb10.hidden = YES;
    if (model.type.integerValue == 1) {
         _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 2) {
        _lb6.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 3) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 4) {
        _lb7.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 5) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 6) {
        _lb8.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 7) {
        _lb4.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 9) {
        _lb9.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
}
- (void)updateCustomerReportCellCashModel:(TJCashModel *)model
{
    _lbName.text = model.name;
    _lbStore.hidden = YES;
    
    _lb1.text = [NSString stringWithFormat:@"稽核收款金额：%@元",model.jihejine];
    _lb2.text = [NSString stringWithFormat:@"应收欠款：%@元",model.qiankuanjine];
    _lb3.text = [NSString stringWithFormat:@"线下收款：%@元",model.xianxiajine];
    _lb4.hidden = YES;
    _lb5.hidden = YES;
    
    _lb6.text = [NSString stringWithFormat:@"回款金额：%@元",model.huikuanjine];
    _lb7.text = [NSString stringWithFormat:@"线上收款：%@元",model.xianshangjine];
    _lb8.text = [NSString stringWithFormat:@"退款金额：%@元",model.tuikuanjine];
    _lb9.hidden = YES;
    _lb10.hidden = YES;
    
    if (model.type.integerValue == 1) {
        _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 2) {
        _lb6.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 3) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 4) {
        _lb7.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 5) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if (model.type.integerValue == 6) {
        _lb8.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
}
- (void)updateCustomerReportCellProParam:(NSDictionary *)param
{
    _lbName.text = param[@"name"];
    _lbStore.hidden = YES;
    
    _lb1.text = [NSString stringWithFormat:@"销售业绩：%@元",param[@"price"]];
    _lb2.text = [NSString stringWithFormat:@"成交：%@人",param[@"cjrs"]];
    _lb3.text = [NSString stringWithFormat:@"普及人数：%@人",param[@"pjrs"]];
    _lb4.text = [NSString stringWithFormat:@"复购人数：%@人",param[@"fgrs"]];
    _lb5.hidden = YES;
    
    _lb6.text = [NSString stringWithFormat:@"业绩占比：%@%@",param[@"zb"],@"%"];
    _lb7.text = [NSString stringWithFormat:@"试做：%@人",param[@"szrs"]];
    _lb8.text = [NSString stringWithFormat:@"普及率：%@%@",param[@"pjl"],@"%"];
    _lb3.text = [NSString stringWithFormat:@"复购率：%@%@",param[@"fgl"],@"%"];
    _lb10.hidden = YES;
    
    if ([param[@"type"] integerValue] == 1) {
        _lb1.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 2) {
        _lb6.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 3) {
        _lb2.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 4) {
        _lb7.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 5) {
        _lb3.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 6) {
        _lb8.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 7) {
        _lb4.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
    if ([param[@"type"] integerValue] == 8) {
        _lb9.textColor = [ColorTools colorWithHexString:@"#FF0000"];
    }
}
@end
