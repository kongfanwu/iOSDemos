//
//  XMHACSendTimeSelectView.m
//  xmh
//
//  Created by ald_ios on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHACSendTimeSelectView.h"
#define kBorderW    0.5
#define kCornerRadius    3
@interface XMHACSendTimeSelectView ()
@property (nonatomic, strong)UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSDictionary *timeDic;
@end
@implementation XMHACSendTimeSelectView
- (void)awakeFromNib
{
    [super awakeFromNib];
    _btn1.layer.borderWidth = _btn2.layer.borderWidth = _btn3.layer.borderWidth = kBorderW;
    _btn1.layer.cornerRadius = _btn2.layer.cornerRadius = _btn3.layer.cornerRadius = kCornerRadius;
    _btn1.layer.borderColor = _btn2.layer.borderColor = _btn3.layer.borderColor = kColor6.CGColor;
    _timeDic = @{@"今日":@"1",@"近七天":@"2",@"近30天":@"3"};
    [_btn1 setTitleColor:kColor6 forState:UIControlStateNormal];
    [_btn2 setTitleColor:kColor6 forState:UIControlStateNormal];
    [_btn3 setTitleColor:kColor6 forState:UIControlStateNormal];
    [_btn4 setImage:UIImageName(@"zhengxu") forState:UIControlStateNormal];
    [_btn4 setImage:UIImageName(@"daoxu") forState:UIControlStateSelected];
    [self tap:_btn1];
    [self tap:_btn4];
}
- (IBAction)tap:(UIButton *)sender
{
    if ([sender isEqual:_btn4]) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            _order = @"desc";
        }else{
            _order = @"asc";
        }
    }else{
        _selectBtn.layer.borderColor = kColor6.CGColor;
        [_selectBtn setTitleColor:kColor6 forState:UIControlStateNormal];
        sender.layer.borderColor = kColorTheme.CGColor;
        [sender setTitleColor:kColorTheme forState:UIControlStateNormal];
        _selectBtn = sender;
    }
    _time = _timeDic[_selectBtn.currentTitle];
    if (_XMHACSendTimeSelectViewBlock) {
        _XMHACSendTimeSelectViewBlock(_time,_order);
    }
}

@end
