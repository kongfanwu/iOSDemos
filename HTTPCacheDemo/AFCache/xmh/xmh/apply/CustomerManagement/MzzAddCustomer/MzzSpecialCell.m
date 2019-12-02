//
//  MzzSpecialCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzSpecialCell.h"
#import <YYWebImage/YYWebImage.h>
@interface MzzSpecialCell()

@end

@implementation MzzSpecialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tips.layer.cornerRadius = 5.0;
    _tips.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = _iconImageView.height/2;
    _iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setupData:(MzzApprovalpersonNew *)model{
    [_iconImageView yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
    [_nameLbl setText:model.name];
    [_frame_name setText:model.frame_name];
    [_timeLbl setText:@""];
    [_state setText:@""];
    _frame_name.textColor = kColor3;
    _frame_name.font = FONT_SIZE(15);
    _nameLbl.textColor = kColor9;
    _nameLbl.font = FONT_SIZE(12);
}

-(void)setupShowData:(SPShowPersonModel *)model{
  
    _selImg.hidden = YES;
    [_iconImageView yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
    [_frame_name setText:model.frame_name?model.frame_name:@""];
    [_nameLbl setText:model.name?model.name:@""];
    _frame_name.textColor = kColor3;
    _frame_name.font = FONT_SIZE(15);
    _nameLbl.textColor = kColor9;
    _nameLbl.font = FONT_SIZE(12);
    if ([model.create_time isEqualToString:@""]) {
         [_timeLbl setText:@""];
    }else{
         [_timeLbl setText:model.create_time];
    }
    
  
    switch (model.type) {
        case 0:
          
            break;
        case 1:
            [_state setText:@"拒绝审批"];
            [_state setTextColor:[ColorTools colorWithHexString:@"#f86f5c"]];
            break;
        case 2:
            [_state setText:@"通过审批"];
            [_state setTextColor:[ColorTools colorWithHexString:@"#48c2af"]];
            break;
        case 3:
            [_state setText:@"审批中"];
            [_state setTextColor:[ColorTools colorWithHexString:@"#f3b337"]];
            break;
        default:
            break;
    }
//    [_state setText:@""];
}
- (void)setIsSelected:(BOOL)isSelected{
    
    [_selImg setHidden:!isSelected];
    
}
@end
