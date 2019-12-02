//
//  LolGukeXiangMuCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LolSingleGuKeSubCell.h"
#import "LolGuKeStateModelList.h"
@implementation LolSingleGuKeSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lb1.font = FONT_SIZE(11);
    _lb1.textColor = kLabelText_Commen_Color_9;
    
    _lb2.font = FONT_SIZE(12);
    _lb2.textColor = kLabelText_Commen_Color_9;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LolGuKeStateModel *)model
{
//    _lb1.text = [NSString stringWithFormat:@"项目名称:%@",model.pro];
    _lb1.text = model.pro;
    [_lb1 sizeToFit];
    _lb1.frame = CGRectMake(15, 15, _lb1.width, _lb1.height);
    
    _lb2.text = model.date;
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(SCREEN_WIDTH - 15 - _lb2.width, 15, _lb2.width, _lb2.height);
    NSString * title = @"";
    if ([model.state isEqualToString:@"xgyy"]) {
        title = @"修改预约";
    }else if ([model.state isEqualToString:@"yyy"]){
        title = @"已预约";
    }else if ([model.state isEqualToString:@"asdd"]){
        title = @"按时到店";
    }else if ([model.state isEqualToString:@"ghwdd"]){
        title = @"规划外到店";
    }else if ([model.state containsString:@"wasdd"]){
        title = @"未按时到店";
    }
    [_imgV lolMarkViewImageName:@"bookbiaoqian" Title:title];
    _imgV.frame = CGRectMake(SCREEN_WIDTH - 80, _lb2.bottom + 10, 0, 0);
}
@end
