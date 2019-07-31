//
//  XMHDateNavBarView.m
//  MonthAndWeekDemo
//
//  Created by kfw on 2019/7/2.
//  Copyright © 2019 kfw. All rights reserved.
//

#import "XMHDateNavBarView.h"

@interface XMHDateNavBarView()
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XMHDateNavBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width - 100) / 2.f, (self.height - 30) / 2.f, 100, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(10,  (self.height - 44) / 2.f, 44, 44);
        [leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.tag = 1;
        [self addSubview:leftBtn];
        leftBtn.backgroundColor = UIColor.redColor;
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(self.width - 44 - 10, (self.height - 44) / 2.f, 44, 44);
        [rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.tag = 2;
        [self addSubview:rightBtn];
        rightBtn.backgroundColor = UIColor.redColor;
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    if (self.changeYearBlock) self.changeYearBlock(sender.tag);
}

- (void)setYear:(NSInteger)year {
    _titleLabel.text = [NSString stringWithFormat:@"%ld年", year];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
