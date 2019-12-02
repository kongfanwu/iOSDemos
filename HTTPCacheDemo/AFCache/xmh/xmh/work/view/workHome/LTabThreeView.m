//
//  LTabThreeView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LTabThreeView.h"

@implementation LTabThreeView
{
    UIButton * _selectBtn;
    UIView * _line;

}
-(UILabel *)chooseLabel
{
    if (!_chooseLabel) {
        _chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 14, 100, 16)];
        _chooseLabel.text=@"按业绩划分";
        _chooseLabel.textColor = RGBColor(102, 102, 102);
        _chooseLabel.font = FONT_SIZE(13);
        _chooseLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooses:)];
        [_chooseLabel addGestureRecognizer:gr];
    }
    return _chooseLabel;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]init];
        _imageView.frame =CGRectMake(_chooseLabel.frame.origin.x+_chooseLabel.frame.size.width+7, 18, 10, 6);
        _imageView.image =[UIImage imageNamed:@"paiming_xiala"];
    }
    return _imageView;
}
-(UIButton *)diButton
{
    if (!_diButton) {
        _diButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _diButton.frame = CGRectMake(SCREEN_WIDTH-15-30, 15, 30, 16);
        [_diButton setTitle:@"最低" forState:UIControlStateNormal];
        _diButton.titleLabel.font = FONT_SIZE(13);
        [_diButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_diButton addTarget:self action:@selector(diButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _diButton;
}
-(UIButton *)gaoButton
{
    if (!_gaoButton) {
        _gaoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _gaoButton.frame = CGRectMake(_diButton.frame.origin.x-25-30, 15, 30, 16);
        [_gaoButton setTitle:@"最高" forState:UIControlStateNormal];
        _gaoButton.titleLabel.font = FONT_SIZE(13);
        [_gaoButton setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
        [_gaoButton addTarget:self action:@selector(gaoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gaoButton;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.chooseLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.diButton];
        [self addSubview:self.gaoButton];
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, SCREEN_WIDTH, 1)];
        line1.backgroundColor = [ColorTools colorWithHexString:@"e5e5e5"];
        [self addSubview:line1];
    }
    return self;
}
-(void)updateTabThreeViewTitles:(NSString *)title withType:(NSString *)type
{
    _chooseLabel.text = title;
    if ([type isEqualToString:@"1"]) {
        [self exchangeBtnColor:_gaoButton];
    }
    [self chooseLabelWith];
}
-(void)chooseLabelWith
{
    // 根据文本计算size，这里需要传入attributes
    CGSize sizeNew = [_chooseLabel.text sizeWithAttributes:@{NSFontAttributeName:_chooseLabel.font}];
    // 重新设置frame
    _chooseLabel.frame = CGRectMake(15, 14, sizeNew.width, sizeNew.height);
    _imageView.frame =CGRectMake(_chooseLabel.frame.origin.x+_chooseLabel.frame.size.width+7, 18, 10, 6);
    
}
//点击最高按钮
-(void)gaoButtonAction:(UIButton *)btn
{
    [self exchangeBtnColor:btn];
    if (_btnGaoButton) {
        _btnGaoButton();
    }
}
//点击最低按钮
-(void)diButtonAction:(UIButton *)btn
{
    [self exchangeBtnColor:btn];
    if (_btnDiButton) {
        _btnDiButton();
    }
}
-(void)exchangeBtnColor:(UIButton *)btn
{
    [_selectBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    _selectBtn.titleLabel.font = FONT_SIZE(13);
    _selectBtn.layer.borderColor = [ColorTools colorWithHexString:@"#cccccc"].CGColor;
    btn.titleLabel.font = FONT_BOLD_SIZE(13);
    [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    _selectBtn = btn;
}
//选择筛选项目
-(void)chooses:(UITapGestureRecognizer *)tapGesture
{
    if (_btnChoose) {
        _btnChoose();
    }
}
@end
