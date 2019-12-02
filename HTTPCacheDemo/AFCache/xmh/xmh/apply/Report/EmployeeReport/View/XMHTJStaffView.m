//
//  XMHTJStaffView.m
//  xmh
//
//  Created by shendengmeiye on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTJStaffView.h"
@interface XMHTJStaffView ()
@end

@implementation XMHTJStaffView
- (void)updateTJStaffCellModel:(TJCustomerModel *)model index:(NSInteger)index
{
    if (index == 0) {
        _lb1.text = [NSString stringWithFormat:@"销售业绩：%@元",model.xiaoshouyeji];
        _lb2.text = [NSString stringWithFormat:@"占比%.2f%%",[model.bfb1 floatValue]];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank1];
    }
    if (index == 1) {
        _lb1.text = [NSString stringWithFormat:@"消耗业绩：%@元",model.xiaohaoyeji];
        _lb2.text = [NSString stringWithFormat:@"占比%.2f%%",[model.bfb2 floatValue]];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank2];
    }
    if (index == 2) {
        _lb1.text = [NSString stringWithFormat:@"接待客次：%@人",model.keci];
        _lb2.text = [NSString stringWithFormat:@"占比%.2f%%",[model.bfb3 floatValue]];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank3];
    }
    if (index == 3) {
        _lb1.text = [NSString stringWithFormat:@"成交顾客数：%@人",model.chengjiao];
        _lb2.text = [NSString stringWithFormat:@"占比%.2f%%",[model.bfb4 floatValue]];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank4];
    }
    if (index == 4) {
        _lb1.text = [NSString stringWithFormat:@"消耗项目数：%@人",model.shicaoxiangmushu];
        _lb2.text = [NSString stringWithFormat:@"占比%.2f%%",[model.bfb5 floatValue]];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank5];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
