//
//  TJDataView.m
//  xmh
//
//  Created by ald_ios on 2018/11/27.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJDataView.h"
#import "TJBBTopModel.h"
#import "TJCustomerTopModel.h"
#import "TJCustomerActiveTopModel.h"
#import "TJExpendTopModel.h"
#import "TJCashTopModel.h"
#import "CustomerRetainTopModel.h"
@interface TJDataView ()
@property (weak, nonatomic) IBOutlet UILabel *lbName1;
@property (weak, nonatomic) IBOutlet UILabel *lbValue1;
@property (weak, nonatomic) IBOutlet UILabel *lbName2;
@property (weak, nonatomic) IBOutlet UILabel *lbValue2;
@property (weak, nonatomic) IBOutlet UILabel *lbName3;
@property (weak, nonatomic) IBOutlet UILabel *lbValue3;
@property (weak, nonatomic) IBOutlet UILabel *lbName4;
@property (weak, nonatomic) IBOutlet UILabel *lbValue4;
@property (weak, nonatomic) IBOutlet UILabel *lbName5;
@property (weak, nonatomic) IBOutlet UILabel *lbValue5;
@property (weak, nonatomic) IBOutlet UILabel *lbName6;
@property (weak, nonatomic) IBOutlet UILabel *lbValue6;
@property (weak, nonatomic) IBOutlet UILabel *lbName7;
@property (weak, nonatomic) IBOutlet UILabel *lbValue7;
@property (weak, nonatomic) IBOutlet UILabel *lbName8;
@property (weak, nonatomic) IBOutlet UILabel *lbValue8;
@property (weak, nonatomic) IBOutlet UILabel *lbName9;
@property (weak, nonatomic) IBOutlet UILabel *lbValue9;
@property (weak, nonatomic) IBOutlet UILabel *lbName10;
@property (weak, nonatomic) IBOutlet UILabel *lbValue10;
@property (weak, nonatomic) IBOutlet UILabel *lbName11;
@property (weak, nonatomic) IBOutlet UILabel *lbValue11;
@property (weak, nonatomic) IBOutlet UILabel *lbName12;
@property (weak, nonatomic) IBOutlet UILabel *lbValue12;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@end
@implementation TJDataView
{
    TJBBTopModel * _bbTopModel;
    TJCustomerTopModel * _customerTopModel;
    TJCustomerActiveTopModel * _customerActiveTopModel;
    TJExpendTopModel * _expendTopModel;
    TJCashTopModel * _cashTopModel;
    CustomerRetainTopModel * _customerRetainTopModel;
    NSString * _type;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _lbName3.hidden = YES;
    _lbValue3.hidden = YES;
    _lbName4.hidden = YES;
    _lbValue4.hidden = YES;
    _lbName5.hidden = YES;
    _lbValue5.hidden = YES;
    _lbName6.hidden = YES;
    _lbValue6.hidden = YES;
    
    
    _lbName9.hidden = YES;
    _lbValue9.hidden = YES;
    _lbName10.hidden = YES;
    _lbValue10.hidden = YES;
    _lbName11.hidden = YES;
    _lbValue11.hidden = YES;
    _lbName12.hidden = YES;
    _lbValue12.hidden = YES;
}
- (void)updateTJDataViewBBModel:(TJBBTopModel *)model;
{
    _bbTopModel = model;
    _lbName1.text = @"接待客次（次）";
    _lbValue1.text = model.keci;
    
    _lbName2.text = @"销售业绩（元）";
    _lbValue2.text = model.xiaoshouyeji;
    
    _lbName3.text = @"消耗业绩（元）";
    _lbValue3.text = model.xiaohaoyeji;
    
    _lbName4.text = @"月累计活动顾客（人）";
    _lbValue4.text = model.yuehuodongguke;
    
    _lbName7.text = @"有效顾客（人）";
    _lbValue7.text = model.youxiaoguke;
    
    _lbName8.text = @"消耗项目数（个）";
    _lbValue8.text = model.shicaoxianmushu;
    
    _lbName9.text = @"消耗/销售占比（%）";
    _lbValue9.text = model.bfb;
    
    _lbName5.hidden = YES;
    _lbValue5.hidden = YES;
    
    _lbName6.hidden = YES;
    _lbValue6.hidden = YES;
    
    _lbName10.hidden = YES;
    _lbValue10.hidden = YES;
    
    _lbName11.hidden = YES;
    _lbValue11.hidden = YES;
    
    _lbName12.hidden = YES;
    _lbValue12.hidden = YES;
    
}
- (IBAction)clickMore:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_bbTopModel || _expendTopModel||_customerRetainTopModel || [_type isEqualToString:@"pro"]) {
        if (sender.selected) {
            _lbName3.hidden = NO;
            _lbValue3.hidden = NO;
            _lbName4.hidden = NO;
            _lbValue4.hidden = NO;
            
            _lbName9.hidden = NO;
            _lbValue9.hidden = NO;
        }
        if (!sender.selected) {
            _lbName3.hidden = YES;
            _lbValue3.hidden = YES;
            _lbName4.hidden = YES;
            _lbValue4.hidden = YES;
            
            _lbName9.hidden = YES;
            _lbValue9.hidden = YES;
        }
    }
    if (_customerTopModel || _customerActiveTopModel) {
        if (sender.selected) {
            _lbName3.hidden = NO;
            _lbValue3.hidden = NO;
            _lbName4.hidden = NO;
            _lbValue4.hidden = NO;
            _lbName5.hidden = NO;
            _lbValue5.hidden = NO;
            _lbName6.hidden = NO;
            _lbValue6.hidden = NO;
            _lbName9.hidden = NO;
            _lbValue9.hidden = NO;
            _lbName10.hidden = NO;
            _lbValue10.hidden = NO;
            _lbName11.hidden = NO;
            _lbValue11.hidden = NO;
            _lbName12.hidden = NO;
            _lbValue12.hidden = NO;
        }
        if (!sender.selected) {
            _lbName3.hidden = YES;
            _lbValue3.hidden = YES;
            _lbName4.hidden = YES;
            _lbValue4.hidden = YES;
            _lbName5.hidden = YES;
            _lbValue5.hidden = YES;
            _lbName6.hidden = YES;
            _lbValue6.hidden = YES;
            _lbName9.hidden = YES;
            _lbValue9.hidden = YES;
            _lbName10.hidden = YES;
            _lbValue10.hidden = YES;
            _lbName11.hidden = YES;
            _lbValue11.hidden = YES;
            _lbName12.hidden = YES;
            _lbValue12.hidden = YES;
        }
    }
    if (_cashTopModel) {
        if (sender.selected) {
            _lbName3.hidden = NO;
            _lbValue3.hidden = NO;
            _lbName4.hidden = NO;
            _lbValue4.hidden = NO;
            _lbName5.hidden = NO;
            _lbValue5.hidden = NO;
            _lbName6.hidden = NO;
            _lbValue6.hidden = NO;
            _lbName9.hidden = NO;
            _lbValue9.hidden = NO;
            _lbName10.hidden = NO;
            _lbValue10.hidden = NO;
            _lbName11.hidden = NO;
            _lbValue11.hidden = NO;
            _lbName12.hidden = NO;
            _lbValue12.hidden = NO;
        }
        if (!sender.selected) {
            _lbName3.hidden = YES;
            _lbValue3.hidden = YES;
            _lbName4.hidden = YES;
            _lbValue4.hidden = YES;
            _lbName5.hidden = YES;
            _lbValue5.hidden = YES;
            _lbName6.hidden = YES;
            _lbValue6.hidden = YES;
            _lbName9.hidden = YES;
            _lbValue9.hidden = YES;
            _lbName10.hidden = YES;
            _lbValue10.hidden = YES;
            _lbName11.hidden = YES;
            _lbValue11.hidden = YES;
            _lbName12.hidden = YES;
            _lbValue12.hidden = YES;
        }
    }
    if (_TJDataViewMoreBlock) {
        _TJDataViewMoreBlock(sender.selected);
    }
}
- (void)updateTJDataViewCustomerModel:(TJCustomerTopModel *)model
{
    _customerTopModel = model;
    _lbName1.text = @"人均接待（次）";
    _lbValue1.text = model.renjunjiedai;
    
    _lbName2.text = @"人均产值（元）";
    _lbValue2.text = model.renjunchanzhi;
    
    _lbName3.text = model.meiricaozuo_name;
    _lbValue3.text = model.meiricaozuo;
    
    _lbName4.text = model.meirixiaohao_name;
    _lbValue4.text = model.meirixiaohao;
    
    _lbName5.text = @"消耗业绩（元）";
    _lbValue5.text = model.xiaohaoyeji;
    
    _lbName6.text = @"成交顾客数（人）";
    _lbValue6.text = model.chengjiaoguke;
    
    _lbName7.text = @"人均操作（个）";
    _lbValue7.text = model.renjuncaozuo;
    
    _lbName8.text = @"人均消耗（元）";
    _lbValue8.text = model.renjunxiaohao;
    
    _lbName9.text = model.meirizuoxiangmu_name;
    _lbValue9.text = model.meirizuoxiangmu;
    
    _lbName10.text = @"销售业绩（元）";
    _lbValue10.text = model.xiaoshouyeji;
    
    _lbName11.text = @"接待客次（次）";
    _lbValue11.text = model.jiedaikeci;
    
    _lbName12.text = @"消耗项目数（次）";
    _lbValue12.text = model.xiaohaoxiangmu;
}
- (void)updateTJDataViewCustomerActiveModel:(TJCustomerActiveTopModel *)model
{
    _customerActiveTopModel = model;
    _lbName1.text = @"人均到店（次）";
    _lbValue1.text = model.renjundaodian;
    
    _lbName2.text = @"人均单价（元）";
    _lbValue2.text = model.renjundanjia;
    
    _lbName3.text = model.meiyuedaodian_name;
    _lbValue3.text = model.meiyuedaodian;
    
    _lbName4.text = @"消费金额（元）";
    _lbValue4.text = model.xiaofeijine;
    
    _lbName5.text = @"耗卡单价（元）";
    _lbValue5.text = model.haokadanjia;
    
    _lbName6.text = @"消费次数（次）";
    _lbValue6.text = model.xiaofeicishu;
    
    _lbName7.text = @"人均项目数（个）";
    _lbValue7.text = model.renjunxiangmushu;
    
    _lbName8.text = model.dancixiaohao_name;
    _lbValue8.text = model.dancixiaohao;
    
    _lbName9.text = model.gt_haokadanjia_name;
    _lbValue9.text = model.gt_haokadanjia;
    
    _lbName10.text = @"消耗金额（元）";
    _lbValue10.text = model.xiaohaojine;
    
    _lbName11.text = @"消耗项目数（个）";
    _lbValue11.text = model.xiaohaoxiangmushu;
    
    _lbName12.text = @"到店次数（次）";
    _lbValue12.text = model.daodiancishu;
}
- (void)updateTJDataViewExpendModel:(TJExpendTopModel *)model
{
    _expendTopModel = model;
    _lbName1.text = @"总负债金额（元）";
    _lbValue1.text = model.zongfuzhai;
    
    _lbName2.text = @"疗程卡负债金额（元）";
    _lbValue2.text = model.liaochengkafuzhaijine;
    
    _lbName3.text = @"储值卡负债金额（元）";
    _lbValue3.text = model.chuzhikafuzhaijine;
    
    _lbName4.text = @"消耗金额（元）";
    _lbValue4.text = model.xiaohaojine;
    
    _lbName7.text = @"规划消耗金额（元）";
    _lbValue7.text = model.guihuaxiaohao;
    
    _lbName8.text = @"疗程卡负债次数（次）";
    _lbValue8.text = model.liaochengkafuzhaicishu;
    
    _lbName9.text = @"储值卡负债张数（张）";
    _lbValue9.text = model.chuzhikafuzhaizhangshu;
    
    _lbName10.text = @"消耗占比（%）";
    _lbValue10.text = model.bfb;
    
    _lbName5.hidden = YES;
    _lbValue5.hidden = YES;
    
    _lbName6.hidden = YES;
    _lbValue6.hidden = YES;
    
    _lbName10.hidden = NO;
    _lbValue10.hidden = NO;
    
    _lbName11.hidden = YES;
    _lbValue11.hidden = YES;
    
    _lbName12.hidden = YES;
    _lbValue12.hidden = YES;
    
}
- (void)updateTJDataViewCashModel:(TJCashTopModel *)model
{
    _cashTopModel = model;
    
    _lbName1.text = @"稽核收款金额（元）";
    _lbValue1.text = model.jihejine;
    
    _lbName2.text = @"回款单数（单）";
    _lbValue2.text = model.huikuandanshu;
    
    _lbName3.text = @"应收回款单数（单）";
    _lbValue3.text = model.qiankuandanshu;
    
    _lbName4.text = @"收款单数（单）";
    _lbValue4.text = model.xianxiadanshu;
    
    _lbName5.text = @"收款单数（单）";
    _lbValue5.text = model.xianshangdanshu;
    
    _lbName6.text = @"退款单数（单）";
    _lbValue6.text = model.tuikuandanshu;
    
    _lbName8.text = @"回款金额（元）";
    _lbValue8.text = model.huikuanjine;
    
    _lbName9.text = @"应收欠款（元）";
    _lbValue9.text = model.qiankuanjine;
    
    _lbName10.text = @"线上收款（元）";
    _lbValue10.text = model.xianshangjine;
    
    _lbName11.text = @"线下收款（元）";
    _lbValue11.text = model.xianxiajine;
    
    _lbName12.text = @"退款金额（元）";
    _lbValue12.text = model.tuikuanjine;
    
    _lbName7.hidden = YES;
    _lbValue7.hidden = YES;
}
- (void)updateTJDataViewCustomerRetainModel:(CustomerRetainTopModel *)model
{
    _customerRetainTopModel = model;
    _lbName1.text = @"保有顾客（人）";
    _lbValue1.text = [NSString stringWithFormat:@"标准值：%@",model.biaozhun];
    
    _lbName2.text = @"新增顾客（人）";
    _lbValue2.text = model.xinzeng;
    
    _lbName3.text = @"转化顾客（人）";
    _lbValue3.text = model.zhuanhua;
    
    _lbName4.text = @"活动顾客（人）";
    _lbValue4.text = model.huodong;
    
    _lbName7.text = @"本月（人）";
    _lbValue7.text = model.benyue;
    
    _lbName8.text = @"承接顾客（人）";
    _lbValue8.text = model.chengjie;
    
    _lbName9.text = @"流失顾客（人）";
    _lbValue9.text = model.liushi;
    
    _lbName10.text = @"有效顾客（人）";
    _lbValue10.text = model.youxiao;
    
    _lbName5.hidden = YES;
    _lbValue5.hidden = YES;
    
    _lbName6.hidden = YES;
    _lbValue6.hidden = YES;
    
    _lbName10.hidden = NO;
    _lbValue10.hidden = NO;
    
    _lbName11.hidden = YES;
    _lbValue11.hidden = YES;
    
    _lbName12.hidden = YES;
    _lbValue12.hidden = YES;
}
- (void)updateTJDataViewProParam:(NSDictionary *)param
{
    _type = @"pro";
    _lbName6.hidden = YES;
    _lbValue6.hidden = YES;
    _lbName12.hidden = YES;
    _lbValue12.hidden = YES;
    _lbName1.text = @"销售业绩（元）";
    _lbValue1.text = param[@"price"];
    
    _lbName2.text = @"成交人数（人）";
    _lbValue2.text = param[@"cjrs"];
    
    _lbName3.text = @"普及人数（人）";
    _lbValue3.text = param[@"pjrs"];
    
    _lbName4.text = @"复购人数（人）";
    _lbValue4.text = param[@"fgrs"];
    
    _lbName7.text = @"业绩占比（%）";
    _lbValue7.text = param[@"zb"];
    
    _lbName8.text = @"试做人数（人）";
    _lbValue8.text = param[@"szrs"];
    
    _lbName9.text = @"普及率（%）";
    _lbValue9.text = param[@"pjl"];
    
    _lbName10.text = @"复购率（%）";
    _lbValue10.text = param[@"fgl"];
    
}
@end
