//
//  SearchView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "JasonSearchView.h"
@interface JasonSearchView()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *searchButton;

@end
@implementation JasonSearchView{
    NSString *_placeHolderStr;
    
    CGRect     _selfFrame;
}
-(UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _searchButton.frame =CGRectMake(SCREEN_WIDTH-80, _searchBar.frame.origin.y, 80, _searchBar.frame.size.height);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:kColor6 forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _searchButton.titleLabel.font = FONT_SIZE(15);
    }
    return _searchButton;
}
- (instancetype)initWithFrame:(CGRect)frame withPlaceholder:(NSString *)holderStr{
    self = [super initWithFrame:frame];
    if (self) {
        _placeHolderStr = holderStr;
        _selfFrame = frame;
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
//    UIImage *leftimage = [UIImage imageNamed:@"sousuo"];
    UIImage *leftimage = [UIImage imageNamed:@"styygl_sousuo"];
    
    
    UIImageView *leftview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, leftimage.size.width, leftimage.size.height)];
   
    leftview.image = leftimage;
    _searchBar = [[SelfSearchBar alloc] initWithFrame:CGRectMake(15, (_selfFrame.size.height - 30) / 2.f, _selfFrame.size.width - 30, 30)];
    _searchBar.delegate = self;
    _searchBar.font = FONT_SIZE(13);
    _searchBar.backgroundColor = kColorF5F5F5;
    _searchBar.tintColor = kLabelText_Commen_Color_9;//改变光标的颜色
    _searchBar.leftView = leftview;
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = _placeHolderStr;
    _searchBar.textColor = kColor3;
    _searchBar.textAlignment = NSTextAlignmentLeft;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.delegate = self;
    _searchBar.layer.cornerRadius = 3;
    _searchBar.layer.masksToBounds = YES;
    [self addSubview:_searchBar];
    
    [_searchBar setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    
    _line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, _selfFrame.size.width, 1)];
    _line1.backgroundColor = kBackgroundColor;
    [self addSubview:_line1];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searchBar doOk];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_btnSearchBlock) {
        _btnSearchBlock();
    }
    return YES;
}
- (void)updateFrame
{
    _searchBar.frame = CGRectMake(15,(_selfFrame.size.height - 35)/2,_selfFrame.size.width-30,35);
}
- (void)updateHaoKaFrame
{
//    _searchBar.frame = CGRectMake(15,(_selfFrame.size.height - 35)/2+4,_selfFrame.size.width-80,35);
    _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, _searchBar.frame.origin.y, _selfFrame.size.width - 80, _searchBar.frame.size.height);
    _line1.frame = CGRectMake(0, _searchBar.bottom+8, _selfFrame.size.width, 1);
    [self addSubview:self.searchButton];
}

- (void)updateShenPiFrame
{
//    _searchBar.frame = CGRectMake(15, 10, self.width - 15 - 50, self.height - 20);
    _searchBar.frame = CGRectMake(15, (self.height - 30) / 2.f, self.width - 15 - 50, 30);
    _line1.frame = CGRectMake(0, self.height - 0.6, self.width, 0.6);
    [self addSubview:self.searchButton];
    _searchButton.frame =CGRectMake(self.width - 50, _searchBar.frame.origin.y, 50, _searchBar.frame.size.height);
}

- (void)updateShenPiSearchFrame
{
    _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, 10, _selfFrame.size.width - 80, self.height - 20);
    _line1.frame = CGRectMake(0, self.height - 1, _selfFrame.size.width, 1);
    [self addSubview:self.searchButton];
}

-(void)searchButtonAction
{
    [_searchBar doOk];
}
- (void)tapd
{
    
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) {
        return YES;
    }
    if (_limitLength > 0) {
        if ( textField.text.length <= _limitLength) {
            return YES;
        }else{
            return NO;
        }
    }
    
    return YES;
}

@end
