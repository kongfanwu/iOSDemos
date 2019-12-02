//
//  CustomerTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/27.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerTableViewCell.h"
#import <YYWebImage/YYWebImage.h>
@interface CustomerTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *LabelName;

@end

@implementation CustomerTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}

- (void)setModel:(CustomerTableViewModel *)model{
    _model = model;
    [_label1 setText:model.labeltitle1];
    [_label2 setText:model.labeltitle2];
    [_label3 setText:model.labeltitle3];
    [_LabelName setText:model.nickName];
    [_iconBtn yy_setImageWithURL:[NSURL URLWithString:model.iconUrl] forState:UIControlStateNormal options:YYWebImageOptionShowNetworkActivity];
}
@end
