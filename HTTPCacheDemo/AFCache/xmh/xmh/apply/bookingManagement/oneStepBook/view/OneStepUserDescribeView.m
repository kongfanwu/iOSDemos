//
//  OneStepUserDescribeView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OneStepUserDescribeView.h"
#import "OneStepCustomerModel.h"
#import <YYWebImage/YYWebImage.h>
#import "CustomerListModel.h"
#import "CustomerMessageModel.h"
@implementation OneStepUserDescribeView

- (void)awakeFromNib{
    [super awakeFromNib];
    _imgv.layer.borderWidth = 0.25;
    _imgv.layer.cornerRadius = 3;
    _imgv.layer.masksToBounds = YES;
    
    _btn1.layer.borderWidth = 0.25;
    _btn1.layer.cornerRadius = 3;
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.borderColor = kBtn_Commen_Color.CGColor;
    
}
- (void)updateOneStepUserDescribeView:(CustomerModel *)model{
    
    if ([model.headimgurl isEqualToString:@"0"]) {
        _imgv.image = kDefaultCustomerImage;
    }else{
        [_imgv yy_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholder:kDefaultCustomerImage];
    }
    _lb1.text = [NSString stringWithFormat:@"所属门店: %@",model.mdname];
    _lb2.text = [NSString stringWithFormat:@"顾客姓名: %@",model.uname];
    _lb3.text = [NSString stringWithFormat:@"顾客电话: %@",model.mobile];
    NSString * str = nil;
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
    [_btn1 setTitle:str forState:UIControlStateNormal];
}
//
- (void)setCModel:(CustomerMessageModel *)cModel{
    _cModel = cModel;
    [_imgv yy_setImageWithURL:[NSURL URLWithString:cModel.headimgurl] placeholder:kDefaultCustomerImage];
    _lb1.text = [NSString stringWithFormat:@"所属门店: %@",cModel.mdname];
    _lb2.text = [NSString stringWithFormat:@"顾客姓名: %@",cModel.uname];
    _lb3.text = [NSString stringWithFormat:@"顾客电话: %@",cModel.mobile];
    [_btn1 setTitle:cModel.grade forState:UIControlStateNormal];
}
@end
