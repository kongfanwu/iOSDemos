//
//  XMHTraceDiscountCouponCell.m
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTraceDiscountCouponCell.h"
#import "XMHCouponModel.h"
#import "NSString+Costom.h"
@interface XMHTraceDiscountCouponCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewW;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb6W;

@end
@implementation XMHTraceDiscountCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _bg.layer.cornerRadius = 5;
    _bg.layer.masksToBounds = YES;
    
    _lb1.font = FONT_MEDIUM_SIZE(17);
    _lb2.font = FONT_BOLD_SIZE(22);
    _lb3.font = FONT_SIZE(12);
    _lb4.font = FONT_SIZE(12);
    _lb5.font = FONT_SIZE(12);
    _lb6.font = FONT_MEDIUM_SIZE(12);
    
    _lb1.textColor = [UIColor whiteColor];
    _lb2.textColor = [ColorTools colorWithHexString:@"#FC558B"];
    _lb3.textColor = kColor9;
    _lb4.textColor = kColor9;
    _lb5.textColor = [ColorTools colorWithHexString:@"#FC558B"];
    _lb6.textColor = [UIColor whiteColor];
    
    _lb6.backgroundColor = [ColorTools colorWithHexString:@"#FC558B"];
    _lb6.layer.cornerRadius = 4;
    _lb6.layer.masksToBounds = YES;
    _btn.userInteractionEnabled = NO;
}

- (void)updateCellType:(XMHTraceDiscountCouponCellType)cellType
{
    if (cellType == XMHTraceDiscountCouponCellTypeEdit) {
        _leftViewW.constant = 35;
        _leftView.hidden = NO;
    }else{
        _leftViewW.constant = 10;
        _leftView.hidden = YES;
    }
}
- (void)updateCellModel:(XMHCouponModel *)model
{
    _lb1.text = [model couponName];
    _btn.selected = model.selected;
    if (model.usable_type.integerValue == 1) {
        _lb4.text = [NSString stringWithFormat:@"有效期：%@--%@",model.start_time,model.end_time];
    }else{
        _lb4.text = [NSString stringWithFormat:@"券有效期: 领券后%@天后生效,有效期%@天",model.delay,model.duration];
    }
    
    if ([model couponType] == XMHActionCouponTypeZheKou) {
        _lb5.hidden = NO;
        _lb2.text = [NSString stringWithFormat:@"%@折",model.discount];
        if (model.fulfill.integerValue != 0){
            _lb5.text = [NSString stringWithFormat:@"最高抵扣%@元",model.fulfill];
        }else{
            _lb5.hidden = YES;
        }
        
    }
    if ([model couponType] == XMHActionCouponTypeLiPin) {
        _lb5.hidden = YES;
        _lb2.text = model.sub_title;
    }
    if ([model couponType] == XMHActionCouponTypeXianJin){
        _lb5.hidden = YES;
        if (model.fulfill.integerValue == 0) {
            _lb2.text = [NSString stringWithFormat:@"%@元",model.price];
        }else{
            _lb2.text = [NSString stringWithFormat:@"%@-%@元",model.fulfill,model.price];
        }
    }
    _lb3.text = @"限门店使用";
    if (model.is_limit_store ==1) {
        _lb3.hidden = YES;
    }
    CGFloat w = [model.brand stringWidthWithFont:FONT_SIZE(12)];
    _lb6W.constant = w + 10;
    _lb6.text = model.brand;
}
@end
