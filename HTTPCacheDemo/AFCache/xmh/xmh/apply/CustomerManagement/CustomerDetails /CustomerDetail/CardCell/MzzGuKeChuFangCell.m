//
//  MzzGuKeChuFangCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzGuKeChuFangCell.h"
#import "ChuFangReporterViewController.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "LNavigationController.h"
@interface MzzGuKeChuFangCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *yuyuejishi;
@property (weak, nonatomic) IBOutlet UILabel *shengyucishu;
@property (weak, nonatomic) IBOutlet UILabel *guihuashijian;

@end
@implementation MzzGuKeChuFangCell
- (IBAction)chufangbaogao:(id)sender {
    ChuFangReporterViewController *VC = [[ChuFangReporterViewController alloc]init];
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString    *token = model.data.token;
    VC.billNum = _model.ordernum;
    VC.token = token;
    VC.name = _model.name;
    VC.img = @"";
    VC.num = [NSString stringWithFormat:@"%ld",_model.num];
    VC.num1 = [NSString stringWithFormat:@"%ld",_model.num1];
    LNavigationController * nav = (LNavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController);
    [nav pushViewController:VC animated:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization cod
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(GuKeChuFang *)model{
    _model = model;
    [_name setText:[NSString stringWithFormat:@"处方名称：%@",model.name]];
    if ([model.zt isEqualToString:@"1"]) {
         [_state setText:@"未完成"];
         [_guihuashijian setText:[NSString stringWithFormat:@"规划时间：%@",model.time]];
        _btn1.hidden = YES;
    }else if ([model.zt isEqualToString:@"2"]){
          [_state setText:@"已终止"];
         [_guihuashijian setText:[NSString stringWithFormat:@"完成时间：%@",model.time]];
        _btn1.hidden = NO;
    }else{
          [_state setText:@"已完成"];
         [_guihuashijian setText:[NSString stringWithFormat:@"完成时间：%@",model.time]];
        _btn1.hidden = NO;
    }
    [_yuyuejishi setText:[NSString stringWithFormat:@"预约技师：%@",model.jis_name]];
    [_shengyucishu setText:[NSString stringWithFormat:@"执行次数：%ld/%ld", model.num1,model.num]];
    _btn1.layer.borderWidth = 1;
    _btn1.layer.borderColor  = kBtn_Commen_Color.CGColor;
}
@end
