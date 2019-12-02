//
//  LSmartAllocationSelectCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSmartAllocationSelectCell.h"
#import <YYWebImage/YYWebImage.h>
@implementation LSmartAllocationSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setModel:(LSAUserModel *)model
{
    _lbName1.text = model.uname;
    _lbStore.text = model.mdname;
    [_imgV1 yy_setImageWithURL:[NSURL URLWithString:model.user_img] placeholder:kDefaultCustomerImage];
    
    _lbName2.text = model.jis_name;
    [_imgV2 yy_setImageWithURL:[NSURL URLWithString:model.jis_img] placeholder:kDefaultJisImage];
    _lbManageNum.text = [NSString stringWithFormat:@"%ld/%@",model.jis_min,model.jis_max];
    
    if (model.isSelect) {
        [_btn1 setImage:[UIImage imageNamed:@"smartxuanzhong"] forState:UIControlStateNormal];
    }else{
        [_btn1 setImage:[UIImage imageNamed:@"smartweixuanzhong"] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
