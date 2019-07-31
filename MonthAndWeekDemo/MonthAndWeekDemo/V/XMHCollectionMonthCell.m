//
//  XMHCollectionMonthCell.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/1.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHCollectionMonthCell.h"
#import "XMHMonthAndWeekModel.h"

@interface XMHCollectionMonthCell()
@property (nonatomic, strong) UIButton *button;
@end

@implementation XMHCollectionMonthCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = UIColor.whiteColor;
        [_button setTitleColor:kColor6 forState:UIControlStateNormal];
        [_button setTitleColor:kColorFF9072 forState:UIControlStateSelected];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.frame = CGRectMake(0, 0, self.width, self.height);
        _button.layer.cornerRadius = _button.height / 2.f;
        _button.layer.masksToBounds = YES;
        _button.userInteractionEnabled = NO;
        [self addSubview:_button];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _button.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)configModel:(XMHMonthAndWeekModel *)model {
    [_button setTitle:model.title forState:UIControlStateNormal];
    if (model.select) {
        _button.layer.borderWidth = 0.6;
        _button.layer.borderColor = kColorFF9072.CGColor;
        _button.selected = YES;
    } else {
        _button.layer.borderWidth = 0.6;
        _button.layer.borderColor = kColorC.CGColor;
        _button.selected = NO;
    }
    
}

@end
