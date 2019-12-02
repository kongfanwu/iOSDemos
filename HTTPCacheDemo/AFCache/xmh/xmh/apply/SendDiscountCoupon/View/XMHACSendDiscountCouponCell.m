//
//  XMHACSendDiscountCouponCell.m
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSendDiscountCouponCell.h"
#import "XMHCouponModel.h"
@interface XMHACSendDiscountCouponCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
@implementation XMHACSendDiscountCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _containerView.layer.cornerRadius = 5;
    _containerView.layer.masksToBounds = YES;
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = _lb6.textColor = kColor9;
    
    _lb1.font = FONT_SIZE(15);
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = _lb6.font = FONT_SIZE(11);
}
- (void)updateCellModel:(XMHCouponModel *)model
{
    _lb1.text = [NSString stringWithFormat:@"券名称：%@",model.name?model.name:@""];
    _lb2.text = [NSString stringWithFormat:@"券类型：%@",[model couponName]];
    _lb3.text = [NSString stringWithFormat:@"券状态：%@",[model couponStatus]];
    _lb4.text = [NSString stringWithFormat:@"面值：%@",[model couponDenomination]];
    _lb5.text = [NSString stringWithFormat:@"券有效期：%@",[model couponUseableType]];
    _lb6.text = [NSString stringWithFormat:@"剩余库存：%@",model.remain_num?model.remain_num:@""];
    _btn.selected = model.selected;
    _btn.userInteractionEnabled = NO;
}


@end
