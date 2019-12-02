//
//  TJStaffInfoView.m
//  xmh
//
//  Created by ald_ios on 2018/12/6.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJStaffInfoView.h"
#import <YYWebImage/YYWebImage.h>
#import "TJStaffDetailModel.h"
#import "NSString+Costom.h"
#import "TJCustomerActiveDetailModel.h"
@interface TJStaffInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb1W;

@end
@implementation TJStaffInfoView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _icon.layer.cornerRadius = _icon.width/2;
    _icon.layer.masksToBounds = YES;
    _btn1.layer.cornerRadius = 3;
    _btn2.layer.cornerRadius = 3;
}
- (void)updateTJStaffInfoViewModel:(TJStaffDetailModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultJisImage];
    _lb1.text = model.name;
    NSString * title = model.name;
    CGFloat w =  [title stringWidthWithFont:FONT_SIZE(16)];
    CGFloat centerX = (SCREEN_WIDTH - 30 - 10 - 63 ) /2;
    if (w >= centerX) {
        self.lb1W.constant = centerX;
    }else{
        self.lb1W.constant = w;
    }
    _lb2.text=  model.store_name;
    _lb3.text = [NSString stringWithFormat:@"工龄：%@",model.age];
    _lb4.text = [NSString stringWithFormat:@"保有顾客：%@人",model.baoyou_num];

    NSString * title1 = model.position;
    CGFloat w1 =  [title1 stringWidthWithFont:FONT_SIZE(11)];
    [_btn1 setTitle:title1 forState:UIControlStateNormal];
    _btn1W.constant = w1 + 10;
    
    NSString * title2 = model.level;
    CGFloat w2 =  [title2 stringWidthWithFont:FONT_SIZE(11)];
    [_btn2 setTitle:title2 forState:UIControlStateNormal];
    _btn2W.constant = w2 + 10;
    
}
- (void)updateTJStaffInfoViewCustomerActiveDetailModel:(TJCustomerActiveDetailModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultJisImage];
    _lb1.text = model.name;
    _lb2.text = model.store_name;
    _lb3.text = model.level;
    _lb4.hidden = YES;
    _btn1.hidden = YES;
    _btn2.hidden = YES;
    CGFloat w =  [model.name stringWidthWithFont:FONT_SIZE(16)];
    self.lb1W.constant = w;
}
@end
