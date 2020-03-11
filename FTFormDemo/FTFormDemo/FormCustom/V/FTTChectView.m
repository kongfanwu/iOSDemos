

//
//  FTTChectView.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/18.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTTChectView.h"
#import "FTTChectButtonModel.h"
#import "ViewControllerProtocol.h"

@implementation FTTChectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setButtonArry:(NSMutableArray *)buttonArry
{
    _buttonArry = buttonArry;
    [self sunways];
}
-(void)setSelect:(BOOL)select
{
    _select = select;
    [self sunways];
}
-(void)sunways
{
    for (int i = 0; i < _buttonArry.count; i++) {
        FTTChectButtonModel *model = _buttonArry[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor grayColor];
        [self addSubview:button];
        [button setTitle:model.title forState:UIControlStateNormal];
        
        CGFloat gap = ([UIScreen mainScreen].bounds.size.width - (130 * _buttonArry.count)) / 3;
        button.frame = CGRectMake(gap + (gap + 130) * i, 5, 130, 50);
        
        
        if (_select == YES) {
            model.select = YES;
        }
        
        if (model.select) {
            button.backgroundColor = [UIColor colorWithRed:233/255.0 green:29/255.0 blue:135/255.0 alpha:1];
        }
    }
}
@end
