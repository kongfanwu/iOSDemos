//
//  CustomerTbHeader.m
//  xmh
//
//  Created by ald_ios on 2018/10/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerTbHeader.h"
#import "DateSubViewModel.h"
@interface CustomerTbHeader ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view11;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view22;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view33;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view44;

@property (weak, nonatomic) IBOutlet UIView *containerView1;//横条1
@property (weak, nonatomic) IBOutlet UIView *containerView2;//横条2
@property (weak, nonatomic) IBOutlet UIView *containerView3;//横条3
@property (weak, nonatomic) IBOutlet UIView *containerView4;//横条4
@property (weak, nonatomic) IBOutlet UIView *topContainerView;//横条容器

@property (weak, nonatomic) IBOutlet UIView *oneTitleView;
@property (weak, nonatomic) IBOutlet UILabel *lbOneName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeight;
@property (weak, nonatomic) IBOutlet UIView *titleContainerView;

@property (weak, nonatomic) IBOutlet UILabel *lbName1;
@property (weak, nonatomic) IBOutlet UILabel *lbValue1;
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore1;

@property (weak, nonatomic) IBOutlet UIImageView *icon11;
@property (weak, nonatomic) IBOutlet UILabel *lbName11;
@property (weak, nonatomic) IBOutlet UILabel *lbValue11;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore11;


@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UILabel *lbName2;
@property (weak, nonatomic) IBOutlet UILabel *lbValue2;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore2;

@property (weak, nonatomic) IBOutlet UIImageView *icon22;
@property (weak, nonatomic) IBOutlet UILabel *lbName22;
@property (weak, nonatomic) IBOutlet UILabel *lbValue22;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore22;

@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UILabel *lbName3;
@property (weak, nonatomic) IBOutlet UILabel *lbValue3;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore3;

@property (weak, nonatomic) IBOutlet UIImageView *icon33;
@property (weak, nonatomic) IBOutlet UILabel *lbName33;
@property (weak, nonatomic) IBOutlet UILabel *lbValue33;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgMore33;

@property (weak, nonatomic) IBOutlet UIImageView *icon4;
@property (weak, nonatomic) IBOutlet UILabel *lbName4;
@property (weak, nonatomic) IBOutlet UILabel *lbValue4;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore4;

@property (weak, nonatomic) IBOutlet UIImageView *icon44;
@property (weak, nonatomic) IBOutlet UILabel *lbName44;
@property (weak, nonatomic) IBOutlet UILabel *lbValue44;
@property (weak, nonatomic) IBOutlet UIImageView *imgMore44;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIView *zhishiqi;

@end
@implementation CustomerTbHeader
{
    UIButton * _selectTitleBtn;
    UIView * _selectView;
    BOOL _canSelect;
    NSString * _module;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _zhishiqi.layer.cornerRadius = 2;
    _zhishiqi.layer.masksToBounds = YES;
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view11 addGestureRecognizer:tap11];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap22 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view22 addGestureRecognizer:tap22];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view3 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer * tap33 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view33 addGestureRecognizer:tap33];
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view4 addGestureRecognizer:tap4];
    
    UITapGestureRecognizer * tap44 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countClick:)];
    [_view44 addGestureRecognizer:tap44];
    
    _containerView3.hidden = YES;
    _containerView4.hidden = YES;
    
    [self titleTap:_btn1];
    
}
- (IBAction)titleTap:(UIButton *)sender
{
    // 左标题tag 100  右标题tag 101
    _selectTitleBtn.selected = NO;
    sender.selected = YES;
    _selectTitleBtn = sender;
    if (_CustomerTbHeaderTitleBlock) {
        _CustomerTbHeaderTitleBlock(sender.tag);
    }
    _zhishiqi.left = sender.left;
}
- (void)updateCustomerTbHeaderModel:(NSArray *)modelArr
{
    if (modelArr.count >= 1) {
        DateSubViewModel * model1 = modelArr[0];
        _icon1.image = UIImageName(model1.iconName);
        _lbName1.text = model1.textName;
        _lbValue1.text = model1.textValue;
        _imgMore1.hidden = !model1.isShow;
    }
   
    if (modelArr.count >= 2) {
        DateSubViewModel * model11 = modelArr[1];
        _icon11.image = UIImageName(model11.iconName);
        _lbName11.text = model11.textName;
        _lbValue11.text = model11.textValue;
        _imgMore11.hidden = !model11.isShow;
    }
    
    if (modelArr.count >= 3) {
        DateSubViewModel * model2 = modelArr[2];
        _icon2.image = UIImageName(model2.iconName);
        _lbName2.text = model2.textName;
        _lbValue2.text = model2.textValue;
    }
   
    if (modelArr.count >= 4) {
        DateSubViewModel * model22 = modelArr[3];
        _icon22.image = UIImageName(model22.iconName);
        _lbName22.text = model22.textName;
        _lbValue22.text = model22.textValue;
    }
   
    if (modelArr.count >= 5) {
        DateSubViewModel * model3 = modelArr[4];
        _icon3.image = UIImageName(model3.iconName);
        _lbName3.text = model3.textName;
        _lbValue3.text = model3.textValue;
    }
   
    if (modelArr.count >= 6) {
        DateSubViewModel * model33 = modelArr[5];
        _icon33.image = UIImageName(model33.iconName);
        _lbName33.text = model33.textName;
        _lbValue33.text = model33.textValue;
    }
    
    if (modelArr.count >= 7) {
        DateSubViewModel * model4 = modelArr[6];
        _icon4.image = UIImageName(model4.iconName);
        _lbName4.text = model4.textName;
        _lbValue4.text = model4.textValue;
    }
    if (modelArr.count == 6) {
        _view4.hidden = _view44.hidden = YES;
    }else{
        _view4.hidden = _view44.hidden = NO;
    }
    if (modelArr.count == 7) {
        _view44.hidden = YES;
        return;
    }
    if (modelArr.count >= 8) {
        DateSubViewModel * model44 = modelArr[7];
        _icon44.image = UIImageName(model44.iconName);
        _lbName44.text = model44.textName;
        _lbValue44.text = model44.textValue;
    }
}
- (void)updateCustomerTbHeaderTitle:(NSArray *)titleArr
{
    if (!titleArr) {//没有标题的情况
        _titleViewHeight.constant = 0;
        _titleContainerView.hidden = YES;
    }else{
        _titleViewHeight.constant = 40;
        _titleContainerView.hidden = NO;
    }
    if (titleArr.count == 1) {
        _lbOneName.text = titleArr[0];
        _oneTitleView.hidden = NO;
    }else{
       _oneTitleView.hidden = YES;
    }
    if (titleArr.count >1) {
        [_btn1 setTitle:titleArr[0] forState:UIControlStateNormal];
    }
    if (titleArr.count >= 2) {
        [_btn2 setTitle:titleArr[1] forState:UIControlStateNormal];
    }
}
- (void)countClick:(UITapGestureRecognizer *)tap
{
    if ([_module isEqualToString:@"YYGL"]) {
        NSString * selectName = @"";
        NSInteger  selectIndex = tap.view.tag - 200;
        for (UIView * subView in tap.view.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                UIImageView * imgV = (UIImageView *)subView;
                if (imgV.tag == tap.view.tag) {
                    if (!imgV.hidden) {
                        if (_CustomerTbHeaderContentBlock) {
                            _CustomerTbHeaderContentBlock(selectIndex,selectName);
                        }
                    }
                }
            }
        }
        return;
    }
    if (!_canSelect) {
        return;
    }
    _selectView.backgroundColor = [UIColor whiteColor];
    _selectView.layer.cornerRadius = 0;
    tap.view.backgroundColor = [ColorTools colorWithHexString:@"#FEF2F8"];
    tap.view.layer.cornerRadius = 22;
    _selectView = tap.view;
    NSString * selectName = @"";
    NSInteger  selectIndex = tap.view.tag - 200;
    for (UIView * subView in tap.view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel * lb = (UILabel *)subView;
//            lb.textColor = kBtn_Commen_Color;
            if (lb.tag == tap.view.tag) {
                selectName = lb.text;
            }
        }
    }
//    for (UIView * subView in _topContainerView.subviews) {
//        if (![subView isEqual:tap.view]) {
//            for (UIView * subsubView in subView.subviews) {
//                if ([subsubView isKindOfClass:[UILabel class]]) {
//                    UILabel * lb = (UILabel *)subsubView;
//                    lb.textColor = kLabelText_Commen_Color_6;
//                }
//            }
//        }
//    }
    if (_CustomerTbHeaderContentBlock) {
        _CustomerTbHeaderContentBlock(selectIndex,selectName);
    }
}
- (IBAction)moreBtnClick:(UIButton *)sender
{
    if (sender.selected == NO) {
        _containerView3.hidden = NO;
        _containerView4.hidden = NO;
    }else{
        _containerView3.hidden = YES;
        _containerView4.hidden = YES;
    }
    sender.selected = !sender.selected;
    if (_CustomerTbHeaderMoreBlock) {
        _CustomerTbHeaderMoreBlock(sender.selected);
    }
}
- (void)updateCustomerSelectStateCanSelect:(BOOL)canSelect
{
    _canSelect = canSelect;
    _view1.backgroundColor = [UIColor whiteColor];
    _view11.backgroundColor = [UIColor whiteColor];
    _view2.backgroundColor = [UIColor whiteColor];
    _view22.backgroundColor = [UIColor whiteColor];
    _view3.backgroundColor = [UIColor whiteColor];
    _view33.backgroundColor = [UIColor whiteColor];
    _view4.backgroundColor = [UIColor whiteColor];
    _view44.backgroundColor = [UIColor whiteColor];
}
- (void)updateCustomerModule:(NSString *)module
{
    _module = module;
}
- (void)updateCustomerTbHeaderStates
{
    _btnMore.selected = YES;
    [self moreBtnClick:_btnMore];
}
@end
