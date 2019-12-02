//
//  WorkCommonCell2.m
//  xmh
//
//  Created by ald_ios on 2018/9/13.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkCommonCell2.h"
#import <YYWebImage/YYWebImage.h>
@interface WorkCommonCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
@implementation WorkCommonCell2
- (void)updateWorkCommonCellXsnrModel:(MzzXsnr*)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultImage];
    _lb1.text = model.user_name;
    _lb2.text = model.name;
    _lb3.text = [NSString stringWithFormat:@"面额：%@元",model.denomination];
    _lb4.text = [NSString stringWithFormat:@"余额：%ld元",model.money];
    _lb5.text = [NSString stringWithFormat:@"平台温馨提示：%@",model.cue];
}
- (void)updateWorkCommonCellFwnrModel:(MzzFwnr*)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultImage];
    _lb1.text = IsEmpty(model.user_name) ? @"" : model.user_name;
    _lb2.text = [NSString stringWithFormat:@"预约项目：%@",IsEmpty(model.pro_name) ? @"" : model.pro_name];
    _lb3.text = [NSString stringWithFormat:@"剩余次数：%ld次",model.num];
    _lb5.text = [NSString stringWithFormat:@"平台温馨提示：%@",model.cue];
//    _lb3.text = [NSString stringWithFormat:@"面额：%@",model.denomination];
//    _lb4.text = [NSString stringWithFormat:@"余额：%ld",model.money];
//    _lb5.text = [NSString stringWithFormat:@"平台温馨提示：%@",model.cue];
}
@end
