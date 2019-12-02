//
//  TJGuKeClassCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJGuKeClassCell.h"

@implementation TJGuKeClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(TJGuKeSubModel *)model
{
    _lbTitle.text = [NSString stringWithFormat:@"%@",model.name];
    _lb1.text = [NSString stringWithFormat:@"%@人",model.hdgk];
    _lb2.text = [NSString stringWithFormat:@"%@人",model.yxgk];
    _lb3.text = [NSString stringWithFormat:@"%@人",model.xzgk];
    _lb4.text = [NSString stringWithFormat:@"%@人",model.xmgk];
    _lb5.text = [NSString stringWithFormat:@"%@人",model.lsgk];
}
@end
