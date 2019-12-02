//
//  WorkTopdataView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTopdataView.h"

@implementation WorkTopdataView
{
    UILabel *yeJiLabel;
    UILabel *monthYeJiLabel;
    UILabel *dayBiaoLabel;
    UILabel *monthBiaoLabel;
}
- (WorkTopdataView *)initWithDataFram:(CGRect)frame withTitleOne:(NSString *)oneTitle anOneTxt:(NSString *)oneText withTitleTwo:(NSString *)twoTtile andTwoText:(NSString *)twoText andRole:(NSInteger)role andImage:(NSString *)imageStr withDayBiaoZhu:(NSString *)dayBiao andMonthBiaoZhu:(NSString *)monthBiao
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *dataView =[[UIView alloc]initWithFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 35, 35)];
        imageView.image = [UIImage imageNamed:imageStr];
        [dataView addSubview:imageView];
        
        UILabel *yeJiTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, 25, 120, 14)];
        yeJiTitleLabel.font = FONT_SIZE(11);
        yeJiTitleLabel.textColor = kLabelText_Commen_Color_6;
        yeJiTitleLabel.text = oneTitle;
        [dataView addSubview:yeJiTitleLabel];
        
        dayBiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, yeJiTitleLabel.frame.origin.y+17, 120, 12)];
        dayBiaoLabel.font = FONT_SIZE(9);
        dayBiaoLabel.textColor = kLabelText_Commen_Color_6;
        dayBiaoLabel.text = dayBiao;
        [dataView addSubview:dayBiaoLabel];

        yeJiLabel = [[UILabel alloc]init];
        if (dayBiao.length != 0) {
            yeJiLabel.frame = CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, dayBiaoLabel.frame.origin.y+dayBiaoLabel.frame.size.height, 120, 17);
        }else{
            yeJiLabel.frame = CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, yeJiTitleLabel.frame.origin.y+yeJiTitleLabel.frame.size.height, 120, 17);
        }
        [yeJiLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        yeJiLabel.textColor = kLabelText_Commen_Color_3;
        yeJiLabel.text = [NSString stringWithFormat:@"%.2f",[oneText floatValue]];
        [dataView addSubview:yeJiLabel];
        
        UILabel *monthYeJiTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, yeJiTitleLabel.frame.origin.y, 120, 14)];
        monthYeJiTitleLabel.font = FONT_SIZE(11);
        monthYeJiTitleLabel.textColor = kLabelText_Commen_Color_6;
        monthYeJiTitleLabel.text = twoTtile;
        [dataView addSubview:monthYeJiTitleLabel];
        
        monthBiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, dayBiaoLabel.frame.origin.y, 120, 12)];
        monthBiaoLabel.font = FONT_SIZE(9);
        monthBiaoLabel.textColor = kLabelText_Commen_Color_6;
        monthBiaoLabel.text = dayBiao;
        [dataView addSubview:monthBiaoLabel];
        
        monthYeJiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, yeJiLabel.frame.origin.y, 120, 17)];
        [monthYeJiLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        monthYeJiLabel.textColor = kLabelText_Commen_Color_3;
        monthYeJiLabel.text = [NSString stringWithFormat:@"%.2f",[twoText floatValue]];
        [dataView addSubview:monthYeJiLabel];
        [self addSubview:dataView];
    }
    return self;
}
-(void)updateViewOnetext:(NSString *)oneText andTwoText:(NSString *)twoText wihtDay:(NSString *)day andMonth:(NSString *)month
{
    yeJiLabel.text = oneText; //[NSString stringWithFormat:@"%.2f",[oneText floatValue]];
    monthYeJiLabel.text = twoText; // [NSString stringWithFormat:@"%.2f",[twoText floatValue]];
    dayBiaoLabel.text = [NSString stringWithFormat:@"%@",day];
    monthBiaoLabel.text = [NSString stringWithFormat:@"%@",month];

}
@end
