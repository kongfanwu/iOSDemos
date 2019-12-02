//
//  LFrameCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFrameCell.h"

@implementation LFrameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(List *)model
{
    _lbName.text = model.name;
}
@end
