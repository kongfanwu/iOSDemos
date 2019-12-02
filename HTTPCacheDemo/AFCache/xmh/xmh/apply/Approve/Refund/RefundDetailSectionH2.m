//
//  RefundDetailSectionH2.m
//  xmh
//
//  Created by ald_ios on 2018/11/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundDetailSectionH2.h"
@interface RefundDetailSectionH2 ()
/** 退款设置 */
@property (weak, nonatomic) IBOutlet UILabel *lbTitle1;
/** 退款总价 */
@property (weak, nonatomic) IBOutlet UILabel *lbTitle11;
/** 退款金额 */
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
/** 业绩划分 */
@property (weak, nonatomic) IBOutlet UILabel *lbTitle2;

@end

@implementation RefundDetailSectionH2
- (void)updateRefundDetailSectionH2Value:(CGFloat)value
{
    _lbValue.text = [NSString stringWithFormat:@"￥%.2f",value];
}
@end
