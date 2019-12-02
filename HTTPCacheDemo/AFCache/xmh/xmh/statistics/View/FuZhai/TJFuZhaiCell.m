//
//  TJFuZhaiCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "TJFuZhaiCell.h"

@implementation TJFuZhaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(TJYeJiDataModel *)model
{
    _lbTitle.text = [NSString stringWithFormat:@"%@",model.name];
    _lb1.text = [NSString stringWithFormat:@"%@人",model.people_num];
    _lb2.text = [NSString stringWithFormat:@"%@个",model.pro_num];
    _lb3.text = [NSString stringWithFormat:@"%@元",model.amount];
    _lb4.text = [NSString stringWithFormat:@"%@%@",model.bfb,@"%"];
    _imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"xunzhang%@",model.sort]];
}
@end
