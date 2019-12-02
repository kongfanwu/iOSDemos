//
//  TJDataTbSectionView.m
//  xmh
//
//  Created by ald_ios on 2018/12/3.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "TJDataTbSectionView.h"
#import "TJDataPickCell.h"
#import "TJSectionTbHeader.h"
#import "TJParamModel.h"
@interface TJDataTbSectionView ()

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageMore;
@property (weak, nonatomic) IBOutlet UIButton *btnTop;
@property (weak, nonatomic) IBOutlet UIButton *btnLow;
@end

@implementation TJDataTbSectionView
{
    UIButton * _selectBtn;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    
    _btnTop.layer.borderWidth = kBorderWidth;
    _btnTop.layer.cornerRadius = _btnTop.height/2;
    _btnTop.layer.masksToBounds = YES;
    _btnTop.layer.borderColor = kColorC.CGColor;
    _btnTop.tag = 100;
    [_btnTop addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self click:_btnTop];
    
    _btnLow.layer.borderWidth = kBorderWidth;
    _btnLow.layer.cornerRadius = _btnLow.height/2;
    _btnLow.layer.masksToBounds = YES;
    _btnLow.layer.borderColor = kColorC.CGColor;
    _btnLow.tag = 101;
    [_btnLow addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    _imageMore.userInteractionEnabled = YES;
    _lbTitle.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_lbTitle addGestureRecognizer:tap];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_imageMore addGestureRecognizer:tap1];
    
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    if (_TJDataTbSectionViewTapBlock) {
        _TJDataTbSectionViewTapBlock();
    }
}
- (void)click:(UIButton *)btn
{
    _selectBtn.layer.borderColor = kColor9.CGColor;
    [_selectBtn setTitleColor:kColor9 forState:UIControlStateNormal];
    
    btn.layer.borderColor = kColorTheme.CGColor;
    [btn setTitleColor:kColorTheme forState:UIControlStateNormal];
    
    _selectBtn = btn;
    
    if (_TJDataTbSectionViewBlock) {
        _TJDataTbSectionViewBlock(btn.tag);
    }
}
- (void)updateTJDataTbSectionViewTItle:(NSString *)title
{
    _lbTitle.text = title;
}
- (void)updateTJDataTbSectionViewLeftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle
{
    [_btnTop setTitle:leftTitle forState:UIControlStateNormal];
    [_btnLow setTitle:rightTitle forState:UIControlStateNormal];
}
@end
