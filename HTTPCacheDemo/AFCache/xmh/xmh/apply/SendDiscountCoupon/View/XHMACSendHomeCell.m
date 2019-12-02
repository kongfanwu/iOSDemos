//
//  XHMACSendHomeCell.m
//  xmh
//
//  Created by ald_ios on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XHMACSendHomeCell.h"
#define kCornerRadius  5
@interface XHMACSendHomeCell ()
@property (weak, nonatomic) IBOutlet UIView *lineTop;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbFrom;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
@implementation XHMACSendHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _containerView.layer.cornerRadius = kCornerRadius;
    _containerView.layer.masksToBounds = YES;
    _lb4.hidden = YES;
    _lbTime.textColor = kColor3;
    _lbFrom.textColor = kColor9;
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = _lb6.textColor = kColor9;
    
    _lbTime.font = FONT_SIZE(16);
    _lbFrom.font = FONT_SIZE(14);
    _lb1.font = _lb4.font = FONT_SIZE(15);
    _lb2.font = _lb3.font  = _lb5.font = _lb6.font = FONT_SIZE(11);
    
}
- (void)updateCellModel:(XMHCouponSendHomeModel *)model
{
    _lbTime.text = model.insert_time;
    _lbFrom.text = [NSString stringWithFormat:@"发起人：%@",model.inper?model.inper:@""];
    
    _lb1.text = [NSString stringWithFormat:@"活动总收款：%@",model.use_price?model.use_price:@""];
    _lb2.text = [NSString stringWithFormat:@"发放人数：%@",model.xf_user?model.xf_user:@""];
    _lb3.text = [NSString stringWithFormat:@"使用人数：%@",model.use_user?model.use_user:@""];
    _lb5.text = [NSString stringWithFormat:@"发放张数：%@",model.xf_ticket?model.xf_ticket:@""];
    _lb6.text = [NSString stringWithFormat:@"使用张数：%@",model.use_ticket?model.use_ticket:@""];
}
@end
