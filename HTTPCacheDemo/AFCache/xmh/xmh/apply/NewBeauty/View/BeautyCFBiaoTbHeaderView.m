//
//  BeautyCFBiaoTbHeaderView.m
//  xmh
//
//  Created by ald_ios on 2019/3/25.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFBiaoTbHeaderView.h"
@interface BeautyCFBiaoTbHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@end
@implementation BeautyCFBiaoTbHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _lb2.textColor = _lb3.textColor = _lb4.textColor  = _lb6.textColor = _lb7.textColor = _lb8.textColor = kColor3;
    _lb2.font = _lb3.font = _lb4.font  = _lb6.font = _lb7.font = _lb8.font = FONT_SIZE(14);

}
- (void)updateViewParam:(NSMutableDictionary *)param
{
    _lb2.text = [NSString stringWithFormat:@"总负债金额：%@",param[@"zfz"]?param[@"zfz"]:@""];
    _lb3.text = [NSString stringWithFormat:@"月均消耗金额：%@",param[@"yjxhje"]?param[@"yjxhje"]:@""];
    _lb4.text = [NSString stringWithFormat:@"消耗项目数：%@",param[@"xhxms"]?param[@"xhxms"]:@""];
    
    _lb6.text = [NSString stringWithFormat:@"活动顾客数：%@",param[@"hdgks"]?param[@"hdgks"]:@""];
    _lb7.text = [NSString stringWithFormat:@"到店次数：%@",param[@"ddcs"]?param[@"ddcs"]:@""];
    _lb8.text = [NSString stringWithFormat:@"当月处方数：%@",param[@"dycfs"]?param[@"dycfs"]:@""];
}
@end
