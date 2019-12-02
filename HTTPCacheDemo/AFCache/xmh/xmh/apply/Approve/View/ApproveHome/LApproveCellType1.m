//
//  LApproveCellType1.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LApproveCellType1.h"
#import <YYWebImage/YYWebImage.h>
@implementation LApproveCellType1

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(10, 10, self.width - 20, self.height - 10);
    
    _imgV.layer.cornerRadius = _imgV.width / 2.f;
    _imgV.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kColorF5F5F5;
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = UIColor.whiteColor;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LApproveDetailModel *)model
{
    [_imgV yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
    _lb1.text = [NSString stringWithFormat:@"%@的调店申请",model.data.initiator];
    _lb2.text = [NSString stringWithFormat:@"申请人: %@",model.data.initiator];
    _lb3.text = [NSString stringWithFormat:@"调出门店: %@",model.data.outStore];
    _lb4.text = [NSString stringWithFormat:@"调入门店: %@",model.data.inStore];
//    NSString * text = @"";
//    if ([model.data.chmdtype isEqualToString:@"1"]) {
//        text = @"临时调店";
//    }else{
//        text = @"永久调店";
//    }
    _lb5.text = [NSString stringWithFormat:@"调店类型: %@",model.data.chmdtype];
    _lb6.text = [NSString stringWithFormat:@"调店原因: %@",model.data.cause];
    _lb8.text = [NSString stringWithFormat:@"%@",model.state];
    _lb8.textColor = [ColorTools colorCauseByText:model.state];
    _lb9.text = [NSString stringWithFormat:@"%@",model.create_time];
    if (model.isRead ==0){
        _lbRead.hidden = NO;
    }else{
       _lbRead.hidden = YES;
    }

}
@end
