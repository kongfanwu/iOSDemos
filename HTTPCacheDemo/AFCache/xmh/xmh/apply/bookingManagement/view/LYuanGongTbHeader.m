//
//  LYuanGongTbHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LYuanGongTbHeader.h"

@implementation LYuanGongTbHeader

-(void)awakeFromNib
{
    [super awakeFromNib];
    _lb1.backgroundColor = kBtn_Commen_Color;
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(15);
}
-(void)setModel:(LolHomeModel *)model
{
    _model = model;
    _lb1.frame = CGRectMake(15, (44- 15)/2, 2, 15);
    _lb2.text = model.name;
    [_lb2 sizeToFit];
    _lb2.frame = CGRectMake(_lb1.right + 15, (44 - _lb2.height)/2, _lb2.width, _lb2.height);
    NSString * title = @"";
    switch (model.state) {
        case 1:
            title = @"休息";
            break;
        case 2:
            title = @"达标";
            break;
        case 3:
            title = @"不达标";
            break;
            
        default:
            break;
    }
    [_imgV lolMarkViewImageName:@"bookbiaoqian" Title:title];
    _imgV.frame = CGRectMake(_lb2.right + 15, 15, 0, 0);
}
@end
