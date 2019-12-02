//
//  BeautyCFBiaoTotalView.m
//  xmh
//
//  Created by ald_ios on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoTotalView.h"
@interface BeautyCFBiaoTotalView ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;

@end
@implementation BeautyCFBiaoTotalView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _lb1.font = FONT_BOLD_SIZE(15);
    _lb2.font = _lb3.font = _lb4.font = _lb5.font = FONT_SIZE(14);
    _lb1.textColor = _lb2.textColor = _lb3.textColor = _lb4.textColor = _lb5.textColor = kColor3;
}
- (void)updateViewParam:(NSMutableDictionary *)param
{
    _lb1.text = @"合计：";
    _lb2.text = [NSString stringWithFormat:@"规划总金额：%@",param[@"ghzje"]?param[@"ghzje"]:@""];
    _lb3.text = [NSString stringWithFormat:@"规划数/顾客数：%@/%@",param[@"ghs"]?param[@"ghs"]:@"",param[@"gks"]?param[@"gks"]:@""];
    _lb4.text = [NSString stringWithFormat:@"规划总次数：%@",param[@"ghzcs"]?param[@"ghzcs"]:@""];
    _lb5.text = [NSString stringWithFormat:@"规划总项目数：%@",param[@"ghzxms"]?param[@"ghzxms"]:@""];
}
@end
