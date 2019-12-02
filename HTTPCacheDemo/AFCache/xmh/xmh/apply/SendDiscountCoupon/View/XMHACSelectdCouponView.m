//
//  XMHACSelectdCouponView.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSelectdCouponView.h"
@interface XMHACSelectdCouponView ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@end
@implementation XMHACSelectdCouponView
- (IBAction)btnClick:(id)sender {
    if (_selectdCouponViewBlock) {
        _selectdCouponViewBlock();
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _btn.backgroundColor = kColorF5F5F5;
    _btn.layer.cornerRadius = 5;
    _infoLab.textColor = kColor6;
    _infoLab.font = FONT_SIZE(15);
}
- (void)updateView:(NSInteger)num;
{
    _infoLab.text = [NSString stringWithFormat:@"已添加%ld张优惠券",num];
}
@end
