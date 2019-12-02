//
//  GKGLDiscountCouponCell.m
//  xmh
//
//  Created by ald_ios on 2019/1/16.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLDiscountCouponCell.h"
#import "NSString+Costom.h"

@interface GKGLDiscountCouponCell ()
@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (weak, nonatomic) IBOutlet UIView *viewDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lbDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbEndTime;
@property (weak, nonatomic) IBOutlet UIButton *lbStore;
@property (weak, nonatomic) IBOutlet UILabel *lbLimit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbStoreW;
@property (weak, nonatomic) IBOutlet UIImageView *jihuo;

@end
@implementation GKGLDiscountCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _viewBG.layer.masksToBounds = YES;
    
}
- (void)updateCellParam:(NSDictionary *)param cellType:(NSInteger )tag
{
    if (tag == 0) {
        _viewDiscount.backgroundColor = [ColorTools colorWithHexString:@"#E92866"];
        
    }
    if (tag == 1) {
        _viewDiscount.backgroundColor = kColorC;
        
        _lbDiscount.textColor =  _lbLimit.textColor = _lbStore.backgroundColor = _lbEndTime.textColor = kColorC;
        _lbName.textColor = [UIColor whiteColor];
    }
    NSString * btnTitle = param[@"name"];
    CGFloat btnW = 45;
    btnW = [btnTitle stringWidthWithFont:FONT_SIZE(12)];
    [_lbStore setTitle:btnTitle forState:UIControlStateNormal];
    _lbStoreW.constant = btnW + 20;
    _lbEndTime.text = [NSString stringWithFormat:@"有效期：%@-%@",param[@"startTime"],param[@"endTime"]];
    _lbLimit.text = @"限门店使用";
    
    if ([param[@"type"] integerValue] == 3) {
        _lbName.text = @"现金券";
        /** 1、如果fulfill有值 显示 fulfill-price   2、如果fulfill没有值 显示 price */
        if ([param[@"fulfill"] integerValue]==0) {
            _lbDiscount.text = [NSString stringWithFormat:@"%@元",param[@"price"]];
        }else{
            _lbDiscount.text = [NSString stringWithFormat:@"%@-%@元",param[@"fulfill"],param[@"price"]];
        }
    }
    if ([param[@"type"] integerValue] == 4) {
        _lbName.text = @"折扣券";
        _lbDiscount.text = [NSString stringWithFormat:@"%@折",param[@"discount"]];
    }
    if ([param[@"type"] integerValue] == 5) {
        _lbName.text = @"礼品券";
        _lbDiscount.text = param[@"name"];
    }
    
    if ([param[@"jh_zt"] integerValue] == 0 && tag == 0) {
       _viewDiscount.backgroundColor = _lbDiscount.textColor =  _lbLimit.textColor = _lbEndTime.textColor = _lbStore.backgroundColor = kColor9;
      _lbName.textColor = [UIColor whiteColor];
        _jihuo.hidden = NO;
    }
}

@end
