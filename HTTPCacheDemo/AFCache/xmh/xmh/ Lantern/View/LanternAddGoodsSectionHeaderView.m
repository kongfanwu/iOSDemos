//
//  LanternAddGoodsSectionHeaderView.m
//  xmh
//
//  Created by ald_ios on 2018/12/29.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternAddGoodsSectionHeaderView.h"
#import "RefundLeftCellModel.h"
@interface LanternAddGoodsSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end
@implementation LanternAddGoodsSectionHeaderView

- (void)updateLanternAddGoodsSectionHeaderViewModel:(RefundLeftCellModel *)model
{
    _lbName.text = model.title;
}
@end
