//
//  MzzMessageTwoCell.m
//  xmh
//
//  Created by Ss H on 2018/11/20.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzMessageTwoCell.h"
@interface MzzMessageTwoCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *adviceLabel;

@end
@implementation MzzMessageTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(MzzPortraitListModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@%%",model.index_name,@": ",model.number];
    self.contentLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"参考值：",model.reference_value_min,@"%",@"~",model.reference_value_max,@"%"];
    self.adviceLabel.text = [NSString stringWithFormat:@"%@%@",@"建议：",model.suggest];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
