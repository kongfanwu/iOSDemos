//
//  LNMsgCell.m
//  xmh
//
//  Created by ald_ios on 2018/8/31.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LNMsgCell.h"

@implementation LNMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor= [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LMsgModel *)model
{
    _lbTime.text = model.time;
    _lbName.text = model.title;
    _lbMsg.lineSpace = 5;
    _lbMsg.text = model.content;
}
@end
