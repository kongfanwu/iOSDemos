//
//  XMHTraceCustomerCell.m
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTraceCustomerCell.h"
#import "GKGLHomeCustomerListModel.h"
#import <YYWebImage/YYWebImage.h>
@interface XMHTraceCustomerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
/** 消费状态 */
@property (weak, nonatomic) IBOutlet UILabel *lb2;
/** 会员等级 */
@property (weak, nonatomic) IBOutlet UILabel *lb3;
/** 顾客状态 */
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewW;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
/** 已预约状态图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imgvState;

@end
@implementation XMHTraceCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _bg.layer.cornerRadius = 5;
    _bg.layer.masksToBounds = YES;
    
    _icon.layer.cornerRadius = _icon.height/2;
    _icon.layer.masksToBounds = YES;
    
    _lb1.textColor = kColor3;
    _lb2.textColor = kColor9;
    _lb3.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    
    _lb1.font = FONT_SIZE(16);
    _lb2.font = FONT_SIZE(13);
    _lb3.font = FONT_SIZE(13);
    _lb4.font = FONT_SIZE(10);
    
    _lb4.layer.borderWidth = 0.5;
    _lb4.layer.cornerRadius = _lb4.height/2;
    _lb4.layer.masksToBounds = YES;
    
    _btn.userInteractionEnabled = NO;
    
}
- (void)updateCellModel:(GKGLHomeCustomerModel *)model;
{
    [self updateCellType:XMHTraceCustomerCellTypeLook];
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _lb4.text = model.zt;
    _lb1.text = model.name;
    _lb2.text = model.show;
    _lb3.text = model.grade_name;
    
    if ([model.zt isEqualToString:@"活动顾客"]) {
        _lb4.backgroundColor = [ColorTools colorWithHexString:@"#FFF3F0"];
        _lb4.textColor = [ColorTools colorWithHexString:@"#FF9072"];
        _lb4.layer.borderColor = [ColorTools colorWithHexString:@"#FF9072"].CGColor;
    }
    if ([model.zt isEqualToString:@"休眠顾客"]) {
        _lb4.backgroundColor = [ColorTools colorWithHexString:@"#FFF7E8"];;
        _lb4.textColor = [ColorTools colorWithHexString:@"#FFAF19"];
        _lb4.layer.borderColor = [ColorTools colorWithHexString:@"#FFAF19"].CGColor;
        
    }
    if ([model.zt isEqualToString:@"流失顾客"]) {
        _lb4.backgroundColor = kColorE5E5E5;
        _lb4.textColor = kColor9;
        _lb4.layer.borderColor = kColor9.CGColor;
    }
    if (model.zt.length ==0) {
        _lb4.hidden = YES;
    }
    _btn.selected = model.selected;
    
    if ([model.is_appo intValue] == 1) {
        _imgvState.hidden = NO;
    }else{
        _imgvState.hidden = YES;
    }
}
- (void)updateCellType:(XMHTraceCustomerCellType)cellType
{
    if (cellType == XMHTraceCustomerCellTypeEdit) {
        _leftViewW.constant = 35;
        _leftView.hidden = NO;
    }else{
        _leftViewW.constant = 10;
        _leftView.hidden = YES;
    }
}
@end
