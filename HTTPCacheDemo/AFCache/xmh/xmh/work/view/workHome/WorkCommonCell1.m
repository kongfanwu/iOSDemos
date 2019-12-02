//
//  WorkCommonCell1.m
//  xmh
//
//  Created by ald_ios on 2018/9/12.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkCommonCell1.h"
#import <YYWebImage/YYWebImage.h>
@interface WorkCommonCell1 ()
@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIImageView *icom;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@end
@implementation WorkCommonCell1
- (void)updateWorkCommonCellDspModel:(MzzDaiShenPi *)model
{
    _lbType.text = model.type;
    _lbTime.text = model.time;
    [_icom yy_setImageWithURL:URLSTR(model.fq_img) placeholder:kDefaultJisImage];
    _lb1.text = [NSString stringWithFormat:@"发起人：%@",model.fq_name];
    _lb2.text = [NSString stringWithFormat:@"所属门店：%@",model.store];
    _lb3.text = [NSString stringWithFormat:@"顾客姓名：%@",model.user_name];
    [_btn1 setTitle:model.state forState:UIControlStateNormal];
}
@end
