//
//  MzzChixukaCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzChixukaCell.h"
@implementation MzzChixukaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateCellModel:(MzzStored_card *)model
{
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"余额：%@",model.money];
    _lb3.text = [NSString stringWithFormat:@"面额：%@",model.denomination];
}
@end
