//
//  BeautyCFBiaoCell.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoCell.h"
#import <YYWebImage/YYWebImage.h>
@interface BeautyCFBiaoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;

@end
@implementation BeautyCFBiaoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _icon.layer.cornerRadius = _icon.height/2;
    _icon.layer.masksToBounds = YES;
    _lb1.textColor = kColor3;
    _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = _lb6.textColor = kColor9;
    _lb1.font = FONT_SIZE(16);
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = _lb6.font = FONT_SIZE(11);
    _lb7.font = FONT_SIZE(15);
    _lb7.textColor = [ColorTools colorWithHexString:@"#FF9072"];
    
    _lb8.font = FONT_SIZE(11);
    _lb8.textColor = [ColorTools colorWithHexString:@"#FFAF19"];
    _lb8.hidden = YES;
}
- (void)updateCellParam:(NSMutableDictionary *)param
{
    [_icon yy_setImageWithURL:param[@"head_img"] placeholder:kDefaultJisImage];
    _lb1.text = param[@"jis_name"]?param[@"jis_name"]:@"";
    _lb2.text = [NSString stringWithFormat:@"规划数/顾客数：%@/%@",param[@"ghs"]?param[@"ghs"]:@"",param[@"gks"]?param[@"gks"]:@""];
    _lb3.text = [NSString stringWithFormat:@"规划总次数：%@",param[@"ghzcs"]?param[@"ghzcs"]:@""];
    _lb4.text = [NSString stringWithFormat:@"规划总金额：%@",param[@"ghzje"]?param[@"ghzje"]:@""];
    _lb5.text = [NSString stringWithFormat:@"规划总项目数：%@",param[@"ghzxms"]?param[@"ghzxms"]:@""];
}
- (void)updateCellHomeParam:(NSMutableDictionary *)param
{
    _lb6.hidden = _lb7.hidden = NO;
    [_icon yy_setImageWithURL:param[@"headimgurl"] placeholder:kDefaultCustomerImage];
    _lb1.text = param[@"user_name"]?param[@"user_name"]:@"";
    _lb2.text = [NSString stringWithFormat:@"总负债：%@",param[@"zfz"]?param[@"zfz"]:@""];
    _lb3.text = [NSString stringWithFormat:@"月均消耗项目数：%@",param[@"yjzxms"]?param[@"yjzxms"]:@""];
    _lb4.text = [NSString stringWithFormat:@"月均耗卡单价：%@",param[@"yjhkdj"]?param[@"yjhkdj"]:@""];
    _lb5.text = [NSString stringWithFormat:@"月到店频次：%@",param[@"yddpc"]?param[@"yddpc"]:@""];
    _lb6.text = @"预计消耗周期";
    _lb7.text = [NSString stringWithFormat:@"%@天",param[@"day"]?param[@"day"]:@""];
    _lb8.hidden = NO;
    _lb8.text = [NSString stringWithFormat:@"未做处方数%@个",param[@"wzcfs"]?param[@"wzcfs"]:@""];
}

@end
