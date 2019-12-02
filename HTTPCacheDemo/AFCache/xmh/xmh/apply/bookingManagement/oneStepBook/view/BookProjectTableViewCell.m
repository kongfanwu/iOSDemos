//
//  BookProjectTableViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/1.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookProjectTableViewCell.h"

@implementation BookProjectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(DaiYuYueModel *)model{
    _lb1.text = model.name;
    _lb2.text = [NSString stringWithFormat:@"剩余次数%ld",model.num - model.num1];
    _lb3.text = [NSString stringWithFormat:@"服务时长%ld",model.shichang];
    if (model.isSelected) {
        [_btn setImage:[UIImage imageNamed:@"book_xuanzhong"] forState:UIControlStateNormal];
    }else{
        [_btn setImage:[UIImage imageNamed:@"book_weixuanzhong"] forState:UIControlStateNormal];
    }
}
@end
