//
//  XMHCollectionWeekCell.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/1.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHCollectionWeekCell.h"
#import "XMHMonthAndWeekModel.h"

@interface XMHCollectionWeekCell()
/** <##> */
@property (nonatomic, strong) UIButton *button;
@end

@implementation XMHCollectionWeekCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = UIColor.whiteColor;
        [_button setTitleColor:kColor6 forState:UIControlStateNormal];
        [_button setTitleColor:kColorFF9072 forState:UIControlStateSelected];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.frame = CGRectMake(0, 0, self.width, 25);
        _button.layer.cornerRadius = _button.height / 2.f;
        _button.layer.masksToBounds = YES;
        _button.userInteractionEnabled = NO;
        [self addSubview:_button];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, _button.bottom + 5, self.width, 15)];
        _label.font = [UIFont systemFontOfSize:11];
        _label.textColor = kColorC;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)configModel:(XMHMonthAndWeekModel *)model {
    _label.text = model.subTitle;
    
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
