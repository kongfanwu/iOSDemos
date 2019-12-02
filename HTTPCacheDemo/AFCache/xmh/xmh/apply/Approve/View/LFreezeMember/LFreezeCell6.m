//
//  LFreezeCell6.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFreezeCell6.h"

@implementation LFreezeCell6

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LApprocePersonModel *)model
{
    _lb1.text = model.name;
    _lb2.text = model.frame_name;
    if (model.isSelect) {
        _btn1.selected = YES;
    }else{
        _btn1.selected = NO;
    }
}

- (void)setPmodel:(SPPersonModel *)pmodel{
    _lb1.text = pmodel.name;
    _lb2.text = pmodel.frame_name;
    if (pmodel.isSelect) {
        _btn1.selected = YES;
    }else{
        _btn1.selected = NO;
    }
}
@end
