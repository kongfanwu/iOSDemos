//
//  BookChuFangCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookChuFangCell.h"

@implementation BookChuFangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(DaiYuYueModel *)model{
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"服务技师:%@",model.jis_name];
    _lb3.text = [NSString stringWithFormat:@"剩余次数:%ld",model.num - model.num1];
    _lb4.text = [NSString stringWithFormat:@"服务项目:%@",model.pres_string];
    _lb5.text = [NSString stringWithFormat:@"规划时间:%@",model.stime];
    if (model.isSelected) {
        [_btn1 setImage:[UIImage imageNamed:@"book_xuanzhong"] forState:UIControlStateNormal];
    }else{
        [_btn1 setImage:[UIImage imageNamed:@"book_weixuanzhong"] forState:UIControlStateNormal];
    }
}
@end
