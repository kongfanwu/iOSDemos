//
//  OrderManagementCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OrderManagementCell.h"
@interface OrderManagementCell()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;

@end
@implementation OrderManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(SLDlistModel *)model{
    _model = model;
    [_lb1 setText:model.name];
    [_lb2 setText:[NSString stringWithFormat:@"%ld",model.sum]];
    [_lb3 setText:[NSString stringWithFormat:@"%ld",model.price]];
}
@end
