//
//  MzzOrderSaleCell.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/2.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzOrderSaleCell.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
@implementation MzzOrderSaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btn1.layer.borderWidth = 1;
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.borderColor = [kBackgroundColor CGColor];
    
    _btn2.layer.borderWidth = 1;
    _btn2.layer.cornerRadius = 3;
    _btn2.layer.borderColor = [kBackgroundColor CGColor];
    
    _btn3.layer.borderWidth = 1;
    _btn3.layer.cornerRadius = 3;
    _btn3.layer.borderColor = [kBackgroundColor CGColor];
    
    
    _btn1.backgroundColor = UIColor.redColor;
   
    _btn2.backgroundColor = UIColor.orangeColor;
    
    _btn3.backgroundColor = UIColor.blueColor;
    
}

- (void)cooperateCardHiddenBtn{
    _btn1.hidden = _btn2.hidden = _btn3.hidden = YES;
}
- (IBAction)btn1Event:(UIButton *)sender {
    
    if (_btn1SaleClick) {
        self.btn1SaleClick(_saleModel,sender.titleLabel.text);
    }
}
- (IBAction)btn2Event:(UIButton *)sender {
    
    if (_btn2SaleClick) {
        self.btn2SaleClick(_saleModel,sender.titleLabel.text);
    }
}
- (IBAction)btn3Event:(UIButton *)sender {
    
    if (_btn3SaleClick) {
        self.btn3SaleClick(_saleModel,sender.titleLabel.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setSaleModel:(SANewDingDanModel *)saleModel{
    _saleModel = saleModel;
     LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _downBgView.hidden = !saleModel.isShow;
    _lbName.text = [NSString stringWithFormat:@"%@:",saleModel.user_name];
    _lbOrderNum.text = saleModel.ordernum? saleModel.ordernum:@"";
    _lb2.text = saleModel.user_name? saleModel.user_name:@"";
    _lb3.text = saleModel.user_mobile? saleModel.user_mobile:@"" ;
    _lb4.text = saleModel.saler? saleModel.saler:@"";
    _lb5.text = saleModel.type_name? saleModel.type_name:@"";
    _lb6.text = saleModel.heji? saleModel.heji:@"";
    _lb9.text = saleModel.pay_time? saleModel.pay_time:@"";
    _lb8.text = saleModel.amount? saleModel.amount:@"";
    [_btnState setTitle:saleModel.order_type_name forState:UIControlStateNormal];
    UIColor *color;
    if (saleModel.order_type == 1) {
        //待付款
        _lbtoBuyTitle.hidden = YES;
        _lb8.hidden = YES;
        _lbBuyTimeTitle.hidden = YES;
        _lb9.hidden = YES;
        _btn1.hidden = YES;
        _btn2.hidden = YES;
        _lbtoBuyTitle.hidden = YES;
        _lb8.hidden = YES;
        _lbBuyTimeTitle.hidden = YES;
        _lb9.hidden = YES;
        color = [ColorTools colorWithHexString:@"#f3b337"];
       
        if (_framework_function_main_role == 3 || _framework_function_main_role == 7 ) {
            _btn1.hidden = NO;
        }
        if (_framework_function_main_role == 3 || _framework_function_main_role == 7 ||[infomodel.data.account isEqualToString:saleModel.inper] ) {
            _btn2.hidden = NO;
        }
    }
    if (saleModel.order_type == 2) {
        //待审批
        _lbtoBuyTitle.hidden = YES;
        _lb8.hidden = YES;
        _lbBuyTimeTitle.hidden = YES;
        _lb9.hidden = YES;
        _lbtoBuyTitle.hidden = YES;
        _lb8.hidden = YES;
        _lbBuyTimeTitle.hidden = YES;
        _lb9.hidden = YES;
        color = [ColorTools colorWithHexString:@"#f3b337"];
        _btn1.hidden = YES;
        _btn2.hidden = YES;
        if (infomodel.data.ID == saleModel.next_person) {
            _btn1.hidden = NO;
            [_btn1 setTitle:@"审批" forState:UIControlStateNormal];
        }
        Join_Code *join_code = infomodel.data.join_code[0];
        if ([infomodel.data.account isEqualToString:saleModel.inper] || [join_code.framework_function_role containsObject:@"3"]|| [join_code.framework_function_role containsObject:@"7"] ) {
            _btn2.hidden = NO;
        }
        
    }
    if (saleModel.order_type == 3) {
        //已代收
        _lbtoBuyTitle.hidden = NO;
        _lb8.hidden = NO;
        _lbBuyTimeTitle.hidden = NO;
        _lb9.hidden = NO;
        color = [ColorTools colorWithHexString:@"#48c2af"];
        [_btn1 setHidden:YES];
        _btn2.hidden = YES;
        if (_framework_function_main_role == 7 ) {
            _btn2.hidden = NO;
           [_btn2 setTitle:@"补签" forState:UIControlStateNormal];
        }
    }
    if (saleModel.order_type == 10) {//
        _lbtoBuyTitle.hidden = NO;
        _lb8.hidden = NO;
        _lbBuyTimeTitle.hidden = NO;
        _lb9.hidden = NO;
        color = [ColorTools colorWithHexString:@"#48c2af"];
        if (_framework_function_main_role == 3) {
            _btn1.hidden = YES;
            _btn2.hidden = YES;
        }else if (_framework_function_main_role == 7){
            _btn1.hidden = NO;
            _btn2.hidden = NO;
        }else if ([infomodel.data.account isEqualToString:saleModel.jis_acc]){
            _btn1.hidden = YES;
            _btn2.hidden = NO;
        }else{
            _btn1.hidden = YES;
            _btn2.hidden = YES;
        }
        [_btn1 setTitle:@"撤销" forState:UIControlStateNormal];
        [_btn2 setTitle:@"补齐项目" forState:UIControlStateNormal];

    }
    if (saleModel.order_type == 5) {
        //未付清
        _lbtoBuyTitle.hidden = NO;
        _lb8.hidden = NO;
        _lbBuyTimeTitle.hidden = NO;
        _lb9.hidden = NO;
        color = [ColorTools colorWithHexString:@"#f86f5c"];
        _btn1.hidden = YES;
        _btn2.hidden = YES;
        if (_framework_function_main_role == 7 || _framework_function_main_role == 3 ) {
            _btn1.hidden = NO;
            _btn2.hidden = NO;
            [_btn1 setTitle:@"终止" forState:UIControlStateNormal];
            [_btn2 setTitle:@"还款" forState:UIControlStateNormal];
        }
    }
    if (saleModel.order_type == 6) {
        //已完成
        _lbtoBuyTitle.hidden = NO;
        _lb8.hidden = NO;
        _lbBuyTimeTitle.hidden = NO;
        _lb9.hidden = NO;
        color = [ColorTools colorWithHexString:@"#48c2af"];
        [_btn1 setHidden:YES];
        [_btn2 setHidden:YES];
    }
    if (saleModel.order_type == 9) {//
        //已终止还款
//        color = [ColorTools colorWithHexString:@"#f3b337"];
    }
    [_btnState setTitleColor:color forState:UIControlStateNormal];
}

@end
