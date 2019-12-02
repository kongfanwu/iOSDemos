//
//  MsgActivityCenterErrorCell.m
//  xmh
//
//  Created by ald_ios on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MsgActivityCenterErrorCell.h"
#import <YYWebImage/YYWebImage.h>
#import "NSString+Costom.h"
@interface MsgActivityCenterErrorCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;
@property (copy, nonatomic) XMHCouponSendCustomerModel * model;
@property (weak, nonatomic) IBOutlet UIButton *btnLevel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLevelW;
@end
@implementation MsgActivityCenterErrorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = _icon.height/2;
    
    _lb1.font = FONT_BOLD_SIZE(14);
    _lb2.font = _lb3.font = FONT_SIZE(12);
    
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = kColor9;
    
    _containerView.layer.masksToBounds = YES;
    _containerView.cornerRadius = 5;
    self.contentView.backgroundColor = kBackgroundColor;
    _btnLevel.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
    _btnLevel.layer.cornerRadius = 2;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateCellModel:(NSObject *)model
{
//    _lb1.text =
//    _lb2.text =
//    _lb3.text =
//    [_icon yy_setImageWithURL:URLSTR(@"") placeholder:kDefaultImage];
}
- (void)updateCellModel:(XMHCouponSendCustomerModel *)model cellFrom:(CellFrom)from
{
    _model = model;
    if (from == CellFromSearch || from == CellFromMsg) {
        _btnDel.hidden = YES;
    }else{
        _btnDel.hidden = NO;
    }
    _lb1.text = model.user_name ? model.user_name:model.name;
    _lb2.text = model.mobile;
    _lb3.text = model.store_name;
    [_icon yy_setImageWithURL:URLSTR(model.pic) placeholder:kDefaultCustomerImage];
    NSString * level = model.grade;
    CGFloat w = [level stringWidthWithFont:FONT_SIZE(10)];
    _btnLevelW.constant = w + 10;
    [_btnLevel setTitle:level forState:UIControlStateNormal];
}
- (IBAction)del:(UIButton *)sender
{
    if (_MsgActivityCenterErrorCellDelBlock) {
        _MsgActivityCenterErrorCellDelBlock(_model);
    }
}
@end
