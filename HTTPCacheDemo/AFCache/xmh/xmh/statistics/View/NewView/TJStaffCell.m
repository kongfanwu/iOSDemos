//
//  TJStaffCell.m
//  xmh
//
//  Created by ald_ios on 2018/12/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJStaffCell.h"
@interface TJStaffCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;

@end
@implementation TJStaffCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)updateTJStaffCellModel:(TJCustomerModel *)model index:(NSInteger)index
{
    if (index == 0) {
        _lb1.text = [NSString stringWithFormat:@"累计销售业绩：%@元",model.xiaoshouyeji];
        _lb2.text = [NSString stringWithFormat:@"占比%@",model.bfb1];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank1];
    }
    if (index == 1) {
        _lb1.text = [NSString stringWithFormat:@"累计消耗业绩：%@元",model.xiaohaoyeji];
        _lb2.text = [NSString stringWithFormat:@"占比%@",model.bfb2];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank2];
    }
    if (index == 2) {
        _lb1.text = [NSString stringWithFormat:@"累计接待客次：%@人",model.keci];
        _lb2.text = [NSString stringWithFormat:@"占比%@",model.bfb3];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank3];
    }
    if (index == 3) {
        _lb1.text = [NSString stringWithFormat:@"累计成交顾客数：%@人",model.chengjiao];
        _lb2.text = [NSString stringWithFormat:@"占比%@",model.bfb4];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank4];
    }
    if (index == 4) {
        _lb1.text = [NSString stringWithFormat:@"累计消耗项目数：%@人",model.shicaoxiangmushu];
        _lb2.text = [NSString stringWithFormat:@"占比%@",model.bfb5];
        _lb3.text = [NSString stringWithFormat:@"排名：%@",model.rank5];
    }
}
@end
