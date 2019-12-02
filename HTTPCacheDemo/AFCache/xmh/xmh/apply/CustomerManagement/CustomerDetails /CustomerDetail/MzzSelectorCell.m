//
//  MzzSelectorCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzSelectorCell.h"

@implementation MzzSelectorCell
{
    UIButton *_titleBtn;
    UIView *_tipView;
    UIView *_tipbackView;
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_titleBtn setTitle:@"顾客管理" forState:UIControlStateNormal];
        [_titleBtn setUserInteractionEnabled:NO];
        [_titleBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        _titleBtn.frame = self.contentView.bounds;
        
        [_titleBtn setTitleColor:[ColorTools colorWithHexString:@"f10180"] forState:UIControlStateSelected];
        [_titleBtn setTitleColor:[ColorTools colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [self.contentView addSubview:_titleBtn];
        
        _tipbackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.height -2, self.contentView.width , 2)];
        [_tipbackView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [self.contentView addSubview:_tipbackView];
        
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(5, self.contentView.height -2, self.contentView.width - 10, 2)];
        [_tipView setHidden:YES];
        [_tipView setBackgroundColor:[ColorTools colorWithHexString:@"f10180"]];
        [self.contentView addSubview:_tipView];
        
        [_titleBtn setSelected:NO];
        [_tipView setHidden:YES];
        
    }
    return self;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    _titleBtn.center = self.contentView.center;
//}
- (void)selfOnclick:(BOOL)onclick{
    
    [_titleBtn setSelected:onclick];
    [_tipView setHidden:!onclick];
    
}
-(void)setTitleText:(NSString *)text{
     [_titleBtn setTitle:text forState:UIControlStateNormal];
}
@end
