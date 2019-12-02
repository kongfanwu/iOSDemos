//
//  LSmartAllocationCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSmartAllocationCell.h"
#import <YYWebImage/YYWebImage.h>
@implementation LSmartAllocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LSAUserModel *)model
{
    _lbName1.text = model.uname;
    _lbStore.text = model.mdname;
    [_imgV1 yy_setImageWithURL:[NSURL URLWithString:model.user_img] placeholder:kDefaultCustomerImage];
    
    _lbName2.text = model.jis_name;
    [_imgV2 yy_setImageWithURL:[NSURL URLWithString:model.jis_img] placeholder:kDefaultJisImage];
    _lbManageNum.text = [NSString stringWithFormat:@"%ld/%@%@",model.jis_min,model.jis_max,@"人"];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld/%@%@",model.jis_min,model.jis_max,@"人"]];
    NSRange range1=[[hintString string]rangeOfString:[NSString stringWithFormat:@"%ld",model.jis_min]];
    [hintString addAttribute:NSForegroundColorAttributeName value:kBtn_Commen_Color range:range1];
    //下面是需要给哪个lable进行赋值
    _lbManageNum.attributedText = hintString;
}
@end
