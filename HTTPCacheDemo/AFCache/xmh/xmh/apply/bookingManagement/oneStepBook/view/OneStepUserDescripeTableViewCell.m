//
//  OneStepUserDescripeTableViewCell.m
//  xmh
//
//  Created by 李晓明 on 2017/12/2.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OneStepUserDescripeTableViewCell.h"
#import <YYWebImage/YYWebImage.h>
#import "CustomerListModel.h"
@implementation OneStepUserDescripeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgv.layer.borderWidth = 0.25;
    _imgv.layer.cornerRadius = 3;
    _imgv.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateOneStepUserDescripeTableViewCell:(CustomerModel *)model{
    if ([model.headimgurl isEqualToString:@"0"]) {
        _imgv.image = kDefaultCustomerImage;
    }else{
        [_imgv yy_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholder:kDefaultCustomerImage];
    }
    _lb1.text = [NSString stringWithFormat:@"所属门店：%@",model.mdname] ;
    _lb2.text = [NSString stringWithFormat:@"顾客姓名：%@",model.uname] ;
    NSString * str = @"";
    switch (model.grade) {
        case 0:
            str = @"粉丝";
            break;
        case 1:
            str = @"新人";
            break;
        case 2:
            str = @"达人";
            break;
        case 3:
            str = @"会员";
            break;
            
        default:
            break;
    }
    _lb3.text = [NSString stringWithFormat:@"顾客等级：%@",str];
    _lb4.text = [NSString stringWithFormat:@"顾客电话：%@",model.mobile] ;
}

@end
