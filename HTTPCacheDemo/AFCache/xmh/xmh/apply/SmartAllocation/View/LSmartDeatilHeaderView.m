//
//  LSmartDeatilHeaderView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LSmartDeatilHeaderView.h"
#import <YYWebImage/YYWebImage.h>
@implementation LSmartDeatilHeaderView
{
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setModel:(LAllocationDetaiModel *)model
{
    _model = model;
    [_imgV1 yy_setImageWithURL:[NSURL URLWithString:model.first.user_img] placeholder:kDefaultCustomerImage];
    _lbName1.text = model.first.user_name;
    _lbl1.text = model.first.mdname;
    _lbl2.text = [NSString stringWithFormat:@"%ld",model.first.ddcs];
    _lbl3.text = [NSString stringWithFormat:@"到店频次: %ld次",model.first.ddpc];
    _lbl4.text = [NSString stringWithFormat:@"消耗金额: %ld元",model.first.xfje];
    _lbl5.text = [NSString stringWithFormat:@"消耗项目: %ld个",model.first.ddcs];
    _lbl6.text = [NSString stringWithFormat:@"耗卡单价: %ld元",model.first.hkdj];
    
  
}
- (void)setListModel:(LAllocationListModel *)listModel
{
    _listModel = listModel;
    [_imgV2 yy_setImageWithURL:[NSURL URLWithString:_listModel.jis_img] placeholder:kDefaultJisImage];
    _lbName2.text = _listModel.jis_name;
    _lbr1.text = [NSString stringWithFormat:@"%ld",_listModel.jis_min];
    _lbr7.text = [NSString stringWithFormat:@"/%@",_listModel.jis_max];
    _lbr2.text = [NSString stringWithFormat:@"%@",_listModel.jis_cql];
    _lbr3.text = [NSString stringWithFormat:@"到店频次: %@次",_listModel.jis_ddpc];
    _lbr4.text = [NSString stringWithFormat:@"销售业绩: %@元",_listModel.jis_xsyj];
    _lbr5.text = [NSString stringWithFormat:@"消耗项目: %@个",_listModel.jis_xhxm];
    _lbr6.text = [NSString stringWithFormat:@"耗卡单价: %@元",_listModel.jis_hkdj];
}
@end
