//
//  OrderServiceCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OrderServiceCell.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
@implementation OrderServiceCell

@synthesize imageView = _imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    _btn1.layer.borderWidth = 1;
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.borderColor = [kBackgroundColor CGColor];
    _btn1.backgroundColor = UIColor.redColor;
    _btn2.layer.borderWidth = 1;
    _btn2.layer.cornerRadius = 3;
    _btn2.layer.borderColor = [kBackgroundColor CGColor];
    _btn2.backgroundColor = UIColor.orangeColor;
    _btn3.layer.borderWidth = 1;
    _btn3.layer.cornerRadius = 3;
    _btn3.layer.borderColor = [kBackgroundColor CGColor];
     _btn3.backgroundColor = UIColor.blueColor;
    _btn5.layer.borderWidth = 1;
    _btn5.layer.cornerRadius = 3;
    _btn5.layer.borderColor = [kBackgroundColor CGColor];
    _btn5.backgroundColor = UIColor.yellowColor;
}

- (void)cooperateCardHiddenBtn{
    _btn1.hidden = _btn2.hidden = _btn3.hidden = YES;
}
- (IBAction)btn1Event:(UIButton *)sender {
    if (_btn1Click) {
        self.btn1Click(_listModel,sender.titleLabel.text);
    }
}
- (IBAction)btn2Event:(UIButton *)sender {
    if (_btn2Click) {
        self.btn2Click(_listModel,sender.titleLabel.text);
    }
    
}
- (IBAction)btn3Event:(UIButton *)sender {
    if (_btn3Click) {
        self.btn3Click(_listModel,sender.titleLabel.text);
    }
    
}
- (IBAction)btn5Event:(id)sender {
    
    if (_btn5SaleClick) {
        self.btn5SaleClick(_listModel,@"");
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setListModel:(SLDlistModel *)listModel
{
    _listModel = listModel;
    _downBgView.hidden = !listModel.isShow;
    _lbName.text = [NSString stringWithFormat:@"%@:",listModel.user_name];
    _lbOrderNum.text = listModel.ordernum? listModel.ordernum:@"";
    _lb1.text = listModel.inper_name? listModel.inper_name:@"";
    _lb2.text = listModel.type_name? listModel.type_name:@"";
    _lb3.text = listModel.stime? listModel.stime:@"";
    _lb4.text = listModel.user_name? listModel.user_name:@"";
    _lb5.text = listModel.mobile? listModel.mobile:@"";
    _lb6.text = listModel.z_price? listModel.z_price:@"";
    _lb7.text = listModel.etime? listModel.etime:@"无";
    [_btnState setTitle:listModel.zt_name forState:UIControlStateNormal];
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _btn1.hidden = YES;
    _btn2.hidden = YES;
    
    if (listModel.img != 0) {
        _btn5.hidden = YES;
    }else{
        _btn5.hidden = NO;
    }
    UIColor *color;
    if (listModel.zt.integerValue ==1) {
        //待结算
        color = [ColorTools colorWithHexString:@"#FF9072"];
        if (_framework_function_main_role == 3 || _framework_function_main_role == 7 ) {
            _btn1.hidden = NO;
        }
        if (_framework_function_main_role == 3 || _framework_function_main_role == 7 ||[infomodel.data.account isEqualToString:listModel.inper]) {
            _btn2.hidden = NO;
        }
        if (_btn2.hidden == YES && _btn1.hidden == YES) {
            self.toZaDanConstraint.constant = 15;
        }else if ((_btn1.hidden == NO&& _btn2.hidden == YES) || (_btn1.hidden == YES&& _btn2.hidden == NO)){
            self.toZaDanConstraint.constant = 115;
        }else if (_btn2.hidden == NO&&_btn1.hidden == NO){
            self.toCeDanConstraint.constant = 100;
        }else{}
    }
    if (listModel.zt.integerValue ==2) {
        //已代收
        color = [ColorTools colorWithHexString:@"#B9B8FB"];
        if ( _framework_function_main_role == 7 ) {
            _btn2.hidden = NO;
            [_btn2 setTitle:@"补签" forState:UIControlStateNormal];
            self.toCeDanConstraint.constant = 15;
        }else{
            self.toZaDanConstraint.constant = 15;
        }
    }
    if (listModel.zt.integerValue ==3) {
        //已完成
        color = [ColorTools colorWithHexString:@"#999999"];
        self.toZaDanConstraint.constant = 15;
    }
    [_btnState setTitleColor:color forState:UIControlStateNormal];
    
    
    NSMutableString * str = [[NSMutableString alloc] init];
    
    for (int i = 0; i < listModel.pro_list.count; i++) {
        NSString * subStr = listModel.pro_list[i];
        if (![subStr isKindOfClass:[NSString class]]) {
            return;
        }
        if (i < listModel.pro_list.count -1) {
            [str appendString:[NSString stringWithFormat:@"%@,",subStr]];
        }else{
            [str appendString:subStr];
        }
    }
    
    for (int i = 0; i < listModel.goods_list.count; i++) {
        NSString * subStr = listModel.goods_list[i];
        if (![subStr isKindOfClass:[NSString class]]) {
            return;
        }
        if (i < listModel.goods_list.count -1) {
            [str appendString:[NSString stringWithFormat:@"%@,",subStr]];
        }else{
            [str appendString:subStr];
        }
    }
    _lb8.text = str;
    if (listModel.isShow) {
        [UIView animateWithDuration:0 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    else
    {
        if (listModel.isShow) {
            [UIView animateWithDuration:0 animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }else{
            [UIView animateWithDuration:0 animations:^{
                self.imageView.transform = CGAffineTransformIdentity;
            }];
        }
    }
    
}


- (void)setCooperateModel:(SLCooperate *)cooperateModel
{
    //    _lbName.text = [NSString stringWithFormat:@"%@:",cooperateModel.user_name];
    //    _lbOrderNum.text = cooperateModel.ordernum;
    //    _lb1.text = cooperateModel.inper_name;
    //    _lb2.text = cooperateModel.type_name;
    //    _lb3.text = cooperateModel.stime;
    //    _lb4.text = cooperateModel.user_name;
    ////    _lb5.text = cooperateModel.inper;
    //    _lb6.text = cooperateModel.z_price;
    //    _lb7.text = cooperateModel.etime;
    //    [_btnState setTitle:cooperateModel.zt_name forState:UIControlStateNormal];
    //    NSMutableString * str = [[NSMutableString alloc] init];
    //    if (cooperateModel.pro_list.count <=0) {
    //        return;
    //    }
    //    for (int i = 0; i < cooperateModel.pro_list.count; i++) {
    //        NSString * subStr = cooperateModel.pro_list[i];
    //        if (![subStr isKindOfClass:[NSString class]]) {
    //            return;
    //        }
    //        if (i < cooperateModel.pro_list.count -1) {
    //            [str appendString:[NSString stringWithFormat:@"%@,",subStr]];
    //        }else{
    //            [str appendString:subStr];
    //        }
    //    }
    //    //    for (NSString * strsub in listModel.pro_list) {
    //    //        if ([strsub isKindOfClass:[NSString class]]) {
    //    //            [str appendString:strsub];
    //    //        }
    //    //    }
    //    _lb8.text = str;
}
- (void)setTuiKuanModel:(SATuiKuanModel *)tuiKuanModel
{
    _lbName.text = [NSString stringWithFormat:@"%@:",tuiKuanModel.user_name];
    _lbOrderNum.text = tuiKuanModel.code;
    _lb1.text = tuiKuanModel.user_name;
    _lb2.text = tuiKuanModel.user_mobile;
    _lb3.text = tuiKuanModel.store_name;
    _lb4.text = tuiKuanModel.inper_name;
    _lb5.text = tuiKuanModel.inper_name;
}
@end
