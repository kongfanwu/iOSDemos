//
//  RefundBottomView.m
//  xmh
//
//  Created by ald_ios on 2018/11/9.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundBottomView.h"
@interface RefundBottomView ()
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UIButton *btnGWC;

@end
@implementation RefundBottomView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _lbNum.layer.masksToBounds = YES;
    _lbNum.layer.borderColor = [UIColor whiteColor].CGColor;
    _lbNum.layer.borderWidth = 1;
    
}
- (IBAction)click:(UIButton *)sender
{
    /** 购物车点击 */
    if (sender.tag == 100) {
        if (_RefundBottomViewGWCBlock) {
            _RefundBottomViewGWCBlock();
        }
    }
    /** 下一步点击 */
    if (sender.tag == 101) {
        if (_RefundBottomViewNextBlock) {
            _RefundBottomViewNextBlock();
        }
    }
}
- (void)updateRefundBottomViewNum:(NSString *)num
{
    _lbNum.text = num;
    if (num.integerValue == 0) {
        _lbNum.hidden = YES;
        [_btnGWC setImage:UIImageName(@"stgkgl_gouwuchewushangpin") forState:UIControlStateNormal];
        
    }else{
        _lbNum.hidden = NO;
        [_btnGWC setImage:UIImageName(@"_st_tkgouwuche") forState:UIControlStateNormal];
    }
}
@end
