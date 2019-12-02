//
//  SearchView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "SearchView.h"
@interface SearchView ()<UISearchBarDelegate>

@end
@implementation SearchView{
    
    BOOL _cancelBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initSubViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame cancelBtn:(BOOL)cancelBtn{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _cancelBtn = cancelBtn;
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    
    CGFloat barW = 0;
    
    if (_cancelBtn) {
        
        barW = 50;
    }
    UISearchBar * bar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 9, SCREEN_WIDTH - barW, 33) ];
    bar.keyboardType = UIKeyboardTypeDefault;
    _bar = bar;
    bar.delegate = self;
    bar.backgroundColor = [UIColor clearColor];
//    bar.showsCancelButton = YES;
    bar.placeholder = @"姓名/手机号";
    for (UIView *subView in bar.subviews) {
        if ([subView isKindOfClass:[UIView  class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
            if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                UITextField *textField = [subView.subviews objectAtIndex:0];
                _textField = textField;
                textField.backgroundColor = kBackgroundColor;
                textField.clearButtonMode = UITextFieldViewModeNever;
                //设置输入字体颜色
                //                    textField.textColor = [UIColor lightGrayColor];
                
                //设置默认文字颜色
                UIColor *color = [UIColor grayColor];
                [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"姓名/手机号"
                                                                                    attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName: FONT_SIZE(14)}]];
                //修改默认的放大镜图片
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
                imageView.backgroundColor = [UIColor clearColor];
                imageView.image = [UIImage imageNamed:@"sousuo"];
                textField.leftView = imageView;
            }
        }
    }
    NSString * title = @"";
    if([_textField isFirstResponder]){
        title = @"取消";
    }else{
        title = @"确定";
    }
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(14);
    btn.frame = CGRectMake(bar.right, 8, 50, 30);
    [self addSubview:btn];
    _btnCancel = btn;
    [self addSubview:bar];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (_searchViewBlock) {
        _searchViewBlock();
    }
    return YES;
}
@end
