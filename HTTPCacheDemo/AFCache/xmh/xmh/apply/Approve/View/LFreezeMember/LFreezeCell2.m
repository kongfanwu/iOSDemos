//
//  LFreezeCell2.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFreezeCell2.h"
#import "LSponsorApproceModel.h"
@implementation LFreezeCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LSponsorApproceModel *)model
{
    _model = model;
    _lb1.text = [NSString stringWithFormat:@"%ld元",(long)model.user_surplus];
    _lb2.text = [NSString stringWithFormat:@"%ld次",(long)model.user_serNum];
    if (model.user_awardNum > 0) {
        _lb3.text = @"有";
    }else{
        _lb3.text = @"无";
    }
}
@end
