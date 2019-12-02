//
//  RefundLeftCell.m
//  xmh
//
//  Created by ald_ios on 2018/11/9.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "RefundLeftCell.h"
#import "RefundLeftCellModel.h"
@interface RefundLeftCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end

@implementation RefundLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateRefundLeftCellModel:(RefundLeftCellModel *)model
{
    if (model.selected) {
        _backView.backgroundColor = [UIColor whiteColor];
        _lbName.textColor = kColorTheme;
        _lbName.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }else{
        _backView.backgroundColor = kColorF5F5F5;
        _lbName.textColor = kColor6;
        _lbName.font = FONT_SIZE(16);
    }
    _lbName.text = model.title;
}
@end
