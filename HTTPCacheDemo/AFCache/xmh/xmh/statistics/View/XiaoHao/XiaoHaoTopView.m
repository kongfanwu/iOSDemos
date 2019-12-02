//
//  XiaoHaoTopView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "XiaoHaoTopView.h"

@implementation XiaoHaoTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(XiaoHaoTopModel *)model
{
    _lb1.text = [NSString stringWithFormat:@"%ld元",model.amount];
    _lb2.text = [NSString stringWithFormat:@"%ld人",model.renshu];
    _lb3.text = [NSString stringWithFormat:@"%ld个",model.pro_num];
}
@end
