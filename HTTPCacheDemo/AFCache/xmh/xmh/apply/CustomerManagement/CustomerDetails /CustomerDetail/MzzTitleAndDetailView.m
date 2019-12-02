//
//  MzzTitleAndDetailView.m
//  xmh
//
//  Created by 张英杰 on 2017/12/9.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTitleAndDetailView.h"
@interface MzzTitleAndDetailView()


@end

@implementation MzzTitleAndDetailView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];

}

- (void)initSubviews{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.text = @"";
        _titleLbl.font = [UIFont systemFontOfSize:12];
        [_titleLbl setTextColor: kLabelText_Commen_Color_9];
        [self addSubview:_titleLbl];
    }
    
    
    if (!_detailLbl) {
         _detailLbl = [[UILabel alloc] init];
        _detailLbl.textAlignment = NSTextAlignmentCenter;
        _detailLbl.text = @"";
        _detailLbl.font = [UIFont boldSystemFontOfSize:14];
        [_detailLbl setTextColor:kLabelText_Commen_Color_3];
        [self addSubview:_detailLbl];
    }
    
    if (!_line1) {
        _line1 = [[UIImageView alloc]init];
        _line1.backgroundColor = kBackgroundColor;
        [self addSubview:_line1];
    }
    if (!_line2) {
        _line2 = [[UIImageView alloc]init];
        _line2.backgroundColor = kBackgroundColor;
        [self addSubview:_line2];
    }
    
    if (!_tap) {
        //创建手势 使用initWithTarget:action:的方法创建
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        
        tap.numberOfTapsRequired = 1;
        //设置手指字数
        tap.numberOfTouchesRequired = 1;
        
        [self addGestureRecognizer:tap];
    }

    [_titleLbl setCenter:CGPointMake(self.width /2, self.height/2 - 5)];
    [_titleLbl setBounds:CGRectMake(0, 0, self.width, self.height/2)];
    [_detailLbl setCenter:CGPointMake(self.width /2, self.height/2 + 13)];
    [_detailLbl setBounds:CGRectMake(0, 0, self.width, self.height/2)];
    //创建边线
    _line1.frame = CGRectMake(0, 0, self.width, 1);
    _line2.frame = CGRectMake(self.width - 1, 5, 1, self.height-10);
}

-(void)tapView:(UITapGestureRecognizer *)sender{
    if (self.click) {
        self.click(self);
    }
}
- (void)setTitle:(NSString *)title andDetail:(NSString *)detail andClick:(TitleAndDetailClicked)click{
    [self initSubviews];
    _titleLbl.text = title;
    _detailLbl.text = detail;
    _click = click;
    
}
- (void)setTitle:(NSString *)title andDetail:(NSString *)detail{
    [self setTitle:title andDetail:detail andClick:nil];
}
@end
