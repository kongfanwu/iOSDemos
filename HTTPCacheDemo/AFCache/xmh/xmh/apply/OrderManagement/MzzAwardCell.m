//
//  MzzAwardCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzAwardCell.h"
@interface MzzAwardCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@end
@implementation MzzAwardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(SaleModel *)model{
    [_lb1 setText:model.name];
    [_lb2 setText:[NSString stringWithFormat:@"%ld",model.mzzAwardCount]];
    [_lb3 setText:[NSString stringWithFormat:@"%ld",model.mzzAwardTotlePrice]];
}
@end
