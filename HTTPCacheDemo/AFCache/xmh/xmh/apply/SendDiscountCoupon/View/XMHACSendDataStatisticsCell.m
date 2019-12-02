//
//  XMHACSendDataStatisticsCell.m
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSendDataStatisticsCell.h"
#define kCornerRadius    5
@interface XMHACSendDataStatisticsCell ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;

@end

@implementation XMHACSendDataStatisticsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _containerView.layer.cornerRadius = kCornerRadius;
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = _lb6.textColor = kColor9;
    
    _lb1.font = FONT_SIZE(15);
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = _lb6.font = FONT_SIZE(11);
    
}
- (void)updateCellModel:(XMHCouponSendDataModel *)model
{
    _lb1.text = [NSString stringWithFormat:@"顾客姓名：%@",model.user_name?model.user_name:@""];
    _lb2.text = [NSString stringWithFormat:@"订单号：%@",model.ordernum?model.ordernum:@""];
    _lb3.text = [NSString stringWithFormat:@"核销美容师：%@",model.jis_name?model.jis_name:@""];
    _lb4.text = [NSString stringWithFormat:@"核销门店：%@",model.store_name?model.store_name:@""];
    _lb5.text = [NSString stringWithFormat:@"使用时间：%@",model.time?model.time:@""];
    _lb6.text = [NSString stringWithFormat:@"订单金额：%@",model.price?model.price:@""];
}
@end
