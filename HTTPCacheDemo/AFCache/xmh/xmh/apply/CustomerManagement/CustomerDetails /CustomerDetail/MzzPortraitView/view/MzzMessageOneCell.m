//
//  MzzMessageOneCell.m
//  xmh
//
//  Created by Ss H on 2018/11/20.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzMessageOneCell.h"
@interface MzzMessageOneCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end
@implementation MzzMessageOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(MzzPortraitListModel *)model
{
    NSString *numStr = [NSString stringWithFormat:@"%@",model.number];
    if (numStr.length == 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@",model.index_name];
    }else{
        self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@%%",model.index_name,@": ",numStr];
    }
    self.contentLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"参考值：",model.reference_value_min,@"%",@"~",model.reference_value_max,@"%"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
