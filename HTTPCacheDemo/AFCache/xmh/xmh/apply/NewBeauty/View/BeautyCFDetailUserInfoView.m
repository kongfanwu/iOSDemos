//
//  BeautyCFDetailUserInfoView.m
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyCFDetailUserInfoView.h"
#import <YYWebImage/YYWebImage.h>
@interface BeautyCFDetailUserInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (nonatomic, strong)NSMutableDictionary * param;
@property (weak, nonatomic) IBOutlet UILabel *lbFinish;
@end
@implementation BeautyCFDetailUserInfoView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _icon.layer.cornerRadius = _icon.height/2;
    _icon.layer.masksToBounds = YES;
    
    _lb1.font = FONT_SIZE(16);
    _lb2.font = _lb3.font = _lb4.font = FONT_SIZE(11);
    _btnRight.titleLabel.font = _btnLeft.titleLabel.font = FONT_SIZE(12);
    
    _lb1.textColor = kColor3;
    _lb3.textColor = kColorTheme;
    _lb2.textColor = _lb4.textColor = kColor6;
    _btnRight.layer.borderColor = _btnLeft.layer.borderColor = kColorTheme.CGColor;
    
    _btnLeft.layer.cornerRadius = _btnRight.layer.cornerRadius =3;
    _btnRight.layer.masksToBounds = _btnRight.layer.masksToBounds = YES;
    _btnLeft.layer.borderWidth = _btnRight.layer.borderWidth = 0.5;
    
    [_btnLeft setTitleColor:kColorTheme forState:UIControlStateNormal];
    [_btnRight setTitleColor:kColorTheme forState:UIControlStateNormal];
    _lbFinish.hidden = YES;
}
/** param 内  key : @"come" 做模块判断 */
/**
 come : @"1"  来自顾客管理
 come : @"2"  来自消息
 come : @"3"  美丽定制
 */
- (void)updateViewParam:(NSMutableDictionary *)param
{
    _param = param;
    [_icon yy_setImageWithURL:param[@"icon"] placeholder:kDefaultCustomerImage];
    _lb1.text = param[@"user_name"]?param[@"user_name"]:@"";
    _lb2.text = @"处方执行：";
    _lb3.text = param[@"num1"];
    _lb4.text = [NSString stringWithFormat:@"/%@",param[@"num"]];
    
    if ([param[@"num1"] integerValue] == 0) {
        [_btnRight setTitle:@"删除处方" forState:UIControlStateNormal];
    }else{
        [_btnRight setTitle:@"结束处方" forState:UIControlStateNormal];
    }
    [_btnLeft setTitle:@"继续开单" forState:UIControlStateNormal];
    if ([param[@"zt"] integerValue]==3) {
        _lbFinish.hidden = NO;
        _lbFinish.text = @"已完成";
        _btnLeft.hidden = YES;
        _btnRight.hidden = YES;
    }
    if ([param[@"zt"] integerValue]==2) {
        _lbFinish.hidden = NO;
        _lbFinish.text = @"已终止";
        _btnLeft.hidden = YES;
        _btnRight.hidden = YES;
    }
    if ([param.allKeys containsObject:@"come"]) {
        if ([param[@"come"] integerValue] == 1) {
            _btnLeft.hidden = _btnRight.hidden = YES;
        }
    }
}
- (IBAction)click:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"删除处方"]) {
        if (_BeautyCFDetailUserInfoViewDelBlock) {
            _BeautyCFDetailUserInfoViewDelBlock(_param);
        }
    }else if ([sender.currentTitle isEqualToString:@"结束处方"]){
        if (_BeautyCFDetailUserInfoViewEndBlock) {
            _BeautyCFDetailUserInfoViewEndBlock(_param);
        }
    }else if ([sender.currentTitle isEqualToString:@"继续开单"]){
        if (_BeautyCFDetailUserInfoViewContinueBlock) {
            _BeautyCFDetailUserInfoViewContinueBlock(_param);
        }
    }else{}
}
@end
