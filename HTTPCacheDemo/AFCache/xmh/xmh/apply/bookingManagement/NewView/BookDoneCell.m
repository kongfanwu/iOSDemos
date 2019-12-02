//
//  BookDoneCell.m
//  xmh
//
//  Created by ald_ios on 2018/10/20.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BookDoneCell.h"
#import <YYWebImage/YYWebImage.h>
#import "YiYuYueModel.h"
@interface BookDoneCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerName;
@property (weak, nonatomic) IBOutlet UILabel *lbJisName;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbTime1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
@implementation BookDoneCell
{
    YiYuYueModel * _model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
    _btn1.layer.borderWidth = 0.5;
    _btn1.layer.borderColor = kColorTheme.CGColor;
    _btn2.layer.borderWidth = 0.5;
    _btn2.layer.borderColor = kColorTheme.CGColor;
}
- (void)updateBookDoneCellModel:(YiYuYueModel *)model
{
    _model = model;
    [_icon yy_setImageWithURL:URLSTR(model.user_headimgurl) placeholder:kDefaultCustomerImage];
    _lbCustomerName.text = [NSString stringWithFormat:@"顾客姓名：%@",model.user_name];
    _lbJisName.text = [NSString stringWithFormat:@"技师姓名：%@",model.jis_name];
    _lbValue.text =  [NSString stringWithFormat:@"服务项目：%@",model.pro_string];
    _lbTime.text =  [NSString stringWithFormat:@"预约时间：%@ %@",model.appo_data,model.appo_time];
}
- (IBAction)btnClick:(UIButton *)sender
{
    if (_BookDoneCellBlock) {
        _BookDoneCellBlock(_model,sender.tag);
    }
}
- (void)updateCellParam:(NSDictionary *)param
{
    if (param[@"user_headimgurl"] == nil || [param[@"user_headimgurl"] isEqual:[NSNull null]]) {
         _icon.image = kDefaultCustomerImage;
    }else{
        [_icon yy_setImageWithURL:URLSTR(param[@"user_headimgurl"]) placeholder:kDefaultCustomerImage];
    }
    NSString * serviceName = @"";
    if ([param.allKeys containsObject:@"pres_name"]) {
        serviceName = param[@"pres_name"];
    }else if ([param.allKeys containsObject:@"pro_name"]){
        serviceName = param[@"pro_name"];
    }
    _lbCustomerName.text = [NSString stringWithFormat:@"顾客姓名：%@",param[@"user_name"]?param[@"user_name"]:@""];
    _lbJisName.text = [NSString stringWithFormat:@"服务技师：%@",param[@"jis_name"]?param[@"jis_name"]:@""];
    _lbValue.text =  [NSString stringWithFormat:@"服务项目：%@",serviceName];
    _lbTime.text =  [NSString stringWithFormat:@"预约时间：%@",param[@"appo_data"]?param[@"appo_data"]:@""];
    _lbTime1.text =  [NSString stringWithFormat:@"完成时间：%@",param[@"serv_data"]?param[@"serv_data"]:@""];
    _lbTime1.hidden = NO;
    _btn1.hidden = _btn2.hidden = YES;
}
@end
