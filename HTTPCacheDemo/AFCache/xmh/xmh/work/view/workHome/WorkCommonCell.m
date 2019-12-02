//
//  WorkDyyCell.m
//  xmh
//
//  Created by ald_ios on 2018/9/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkCommonCell.h"
#import <YYWebImage/YYWebImage.h>
@interface WorkCommonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbJis;
@property (weak, nonatomic) IBOutlet UILabel *lbPro;
@property (weak, nonatomic) IBOutlet UIButton *btnState;
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@end
@implementation WorkCommonCell
//待预约模型
- (void)updateWorkCommonCellDyyModel:(MzzDaiYuYue *)model
{
    _viewBg.hidden = YES;
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultJisImage];
    _lbName.text = model.user_name;
    _lbJis.text = [NSString stringWithFormat:@"技师：%@",model.jis_name];
    _lbPro.text = [NSString stringWithFormat:@"项目：%@",model.pro_name];
}
//开发管控模型
- (void)updateWorkCommonCellKfgkModel:(MzzKfgk *)model
{
    _viewBg.hidden = NO;
    UIColor * color = [ColorTools colorCauseByText:model.type];
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _lbName.text = model.user_name;
    _lbJis.text = [NSString stringWithFormat:@"等级：%@",model.grade];
    _lbPro.text = [NSString stringWithFormat:@"技师：%@",model.jis_name];
    [_btnState setTitle:model.type forState:UIControlStateNormal];
    [_btnState setTitleColor:color forState:UIControlStateNormal];
    _viewBg.backgroundColor = [color colorWithAlphaComponent:0.1];
}
//客情维护模型
- (void)updateWorkCommonCellKqwhModel:(MzzKqwh *)model
{
    _viewBg.hidden = NO;
    UIColor * color = [ColorTools colorCauseByText:model.type];
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultCustomerImage];
    _lbName.text = model.user_name;
    _lbJis.text = [NSString stringWithFormat:@"等级：%@",model.grade];
    _lbPro.text = [NSString stringWithFormat:@"技师：%@",model.jis_name];
    [_btnState setTitle:model.type forState:UIControlStateNormal];
    [_btnState setTitleColor:color forState:UIControlStateNormal];
    _viewBg.backgroundColor = [color colorWithAlphaComponent:0.1];
}
@end
