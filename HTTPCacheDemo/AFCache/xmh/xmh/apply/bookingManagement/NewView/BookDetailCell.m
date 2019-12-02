//
//  BookDetailCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookDetailCell.h"
#import "LolDetailModel.h"
@interface BookDetailCell ()
/** cell标题 */
@property (weak, nonatomic) IBOutlet UILabel *lb;
/**
 * 0. 服务项目
 * 1. 服务技师
 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
/**
 * 0. 项目名称
 * 1. 服务技师
 */
@property (weak, nonatomic) IBOutlet UILabel *lb2;
/**
 * 0. 服务时长
 * 1. 服务时间
 */
@property (weak, nonatomic) IBOutlet UILabel *lb3;
/**
 * 0. 服务时长
 * 1. 服务时间
 */
@property (weak, nonatomic) IBOutlet UILabel *lb4;

@end
@implementation BookDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateBookDetailCellModel:(LolDetailModel *)model
{
    if (model.cellIndex == 0) {
        _lb.text = @"请选择顾客预约内容";
        _lb1.text = @"服务项目：";
        _lb2.text = model.pro_list;
        _lb3.text = @"服务时长：";
        _lb4.text = [NSString stringWithFormat:@"%ld",model.max_time];
    }
    if (model.cellIndex == 1) {
        _lb.text = @"请选择服务技师时间";
        _lb1.text = @"服务技师：";
        _lb2.text = model.jis_name?model.jis_name:@"";
        _lb3.text = @"服务时间：";
        _lb4.text = model.appo_data?model.appo_data:@"";
    }
}
@end
