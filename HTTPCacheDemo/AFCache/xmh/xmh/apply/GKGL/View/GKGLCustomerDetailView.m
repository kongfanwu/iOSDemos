//
//  GKGLCustomerDetailView.m
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLCustomerDetailView.h"
@interface GKGLCustomerDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
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
@end
@implementation GKGLCustomerDetailView

- (void)updateGKGLCustomerDetailViewParamDic:(NSDictionary *)param tag:(NSInteger)tag
{
    if (tag == 1) {
        _lbTitle.text = @"账户统计";
        _lbName1.text = @"总余额（元）";
        _lbName2.text = @"账户余额（元）";
        _lbName3.text = @"总余次（次）";
        _lbName4.text = @"储值余额（元）";
        _lbName5.text = @"总欠款（元）";
        _lbName6.text = @"疗程卡（个）";
        _lbName7.text = @"疗程余额（元）";
        _lbName8.text = @"分期单数（单）";
        _lbName9.hidden = _lbValue9.hidden = YES;
        
        _lbValue1.text = param[@"z_price"];
        _lbValue2.text = param[@"bank_price"];
        _lbValue3.text = param[@"z_num"];
        _lbValue4.text = param[@"chuzhi_price"];
        _lbValue5.text = param[@"qiankuan"];
        _lbValue6.text = param[@"liaocheng_num"];
        _lbValue7.text = param[@"liaocheng_price"];
        _lbValue8.text = param[@"fq_num"];
    }
    if (tag == 2) {
        _lbTitle.text = @"行为统计";
        _lbName1.text = @"累计购买金额（元）";
        _lbName2.text = @"累计消耗金额（元）";
        _lbName3.text = @"月均到店次数（次）";
        _lbName4.text = @"累计消费次数（次）";
        _lbName5.text = @"累计到店次数（次）";
        _lbName6.text = @"均次耗卡单价（元）";
        _lbName7.text = @"持有卡项（张）";
        _lbName8.text = @"累计消耗项目数（个）";
        _lbName9.text = @"待续卡项（张）";
        
        _lbValue1.text = param[@"sales_price"];
        _lbValue2.text = param[@"serv_price"];
        _lbValue3.text = param[@"avg_daodian"];
        _lbValue4.text = param[@"sales_num"];
        _lbValue5.text = param[@"daodian"];
        _lbValue6.text = param[@"avg_serv_price"];
        _lbValue7.text = param[@"card_num"];
        _lbValue8.text = param[@"serv_pro_num"];
        _lbValue9.text = param[@"xuka"];
    }
}
@end
