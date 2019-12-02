//
//  RefundGWCCell.m
//  xmh
//
//  Created by ald_ios on 2018/11/14.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundGWCCell.h"
#import "RefundListModel.h"
@interface RefundGWCCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;

@end

@implementation RefundGWCCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)updateRefundGWCCellModel:(RefundModel *)model
{
    _lbName.text = model.name.length > 0?model.name:model.ordernum;
    _lbValue.text = [NSString stringWithFormat:@"￥%@",model.paramValue];
}
@end
