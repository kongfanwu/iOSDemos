//
//  LUserInfoView.m
//  xmh
//
//  Created by ald_ios on 2018/9/7.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LUserInfoView.h"
#import <YYWebImage/YYWebImage.h>
#import "MineTopModel.h"
@interface LUserInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UILabel *lbStore;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@end
@implementation LUserInfoView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _icon.layer.cornerRadius = 30;
    _icon.layer.masksToBounds = YES;
    _btn1.layer.cornerRadius = 8;
    _btn1.layer.borderWidth = 0.5;
    _btn1.layer.borderColor = [ColorTools colorWithHexString:@"ffaf19"].CGColor;
    _btn2.layer.cornerRadius = 8;
    _btn2.layer.borderWidth = 0.5;
    _btn2.layer.borderColor = [ColorTools colorWithHexString:@"ffaf19"].CGColor;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    
    _btn1.titleLabel.font = [UIFont systemFontOfSize:10];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:10];
    _lbStore.font = [UIFont systemFontOfSize:12];
    _lbStore.textColor = kLabelText_Commen_Color_9;
}
+ (instancetype)loadUserInfoView
{
   return loadNibName(@"LUserInfoView");
}
- (void)updateUserInfoViewModel:(MineTopModel*)model
{
    [_icon yy_setImageWithURL:URLSTR(model.img) placeholder:kDefaultJisImage];
    _lbName.text = model.name;
    [_btn1 setTitle:[NSString stringWithFormat:@"顾客保有%ld人",model.user] forState:UIControlStateNormal];
    [_btn2 setTitle:[NSString stringWithFormat:@"工作%ld年",model.work] forState:UIControlStateNormal];
    _lbStore.text = model.post;
}
- (void)tap
{
    if (_UserInfoViewBlock) {
        _UserInfoViewBlock();
    }
}
@end
