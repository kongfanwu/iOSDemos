//
//  MzzOrganizationCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzOrganizationCell.h"
#import "MzzLevelModel.h"
#import "MzzFilterBaseModel.h"
@interface MzzOrganizationCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *glgk;
@property (weak, nonatomic) IBOutlet UILabel *glgk_bfb;
@property (weak, nonatomic) IBOutlet UILabel *hdgk;
@property (weak, nonatomic) IBOutlet UILabel *hdgk_bfb;
@property (weak, nonatomic) IBOutlet UILabel *yxgk;
@property (weak, nonatomic) IBOutlet UILabel *yxgk_bfb;

@end

@implementation MzzOrganizationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(MzzCustomerLevelModel *)data{
    [_nameLbl setText:data.name];
    [_glgk setText:[NSString stringWithFormat:@"管理顾客%ld人",data.glgk]];
    [_glgk_bfb  setText:[NSString stringWithFormat:@"占比%ld%%",data.glgk_bfb]];
    [_hdgk setText:[NSString stringWithFormat:@"活动顾客%ld人",data.hdgk]];
    [_hdgk_bfb setText:[NSString stringWithFormat:@"占比%ld%%",data.hdgk_bfb]];
    [_yxgk setText:[NSString stringWithFormat:@"有效顾客%ld",data.yxgk]];
    [_yxgk_bfb setText:[NSString stringWithFormat:@"占比%ld%%",data.yxgk_bfb]];
 
    
}
@end
