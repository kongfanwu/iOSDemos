//
//  XMHNumberView.m
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHNumberView.h"

@interface XMHNumberView()
/** <##> */
@property (nonatomic, strong) UILabel *numberLabel;
/** <##> */
@property (nonatomic, strong) UIButton *leftButton;
@end

@implementation XMHNumberView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxNumber = NSIntegerMax;
        self.minNumber = 1;
        
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton = leftButton;
        [leftButton setImage:UIImageName(@"jianhao") forState:UIControlStateNormal];
        [self addSubview:leftButton];
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
            make.centerY.equalTo(self);
            make.left.equalTo(self);
        }];
        WeakSelf
        __weak typeof(self) _self = self;
        [leftButton bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            NSInteger newNumbet = [weakSelf.numberLabel.text integerValue];
            if (newNumbet <= weakSelf.minNumber) {
                return;
            }
            weakSelf.numberLabel.text = @(--newNumbet).stringValue;
            weakSelf.currentNumber = newNumbet;
            if (self.didChangeBlock) self.didChangeBlock(weakSelf);
            if (self.delectChangeBlock) self.delectChangeBlock(weakSelf);
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:UIImageName(@"jiahao") forState:UIControlStateNormal];
        [self addSubview:rightButton];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
            make.centerY.equalTo(self);
            make.right.equalTo(self);
        }];
        
        [rightButton bk_addEventHandler:^(id sender) {
            __strong typeof(_self) self = _self;
            NSInteger newNumbet = [weakSelf.numberLabel.text integerValue];
            if (newNumbet >= self.maxNumber) {
                [MzzHud toastWithTitle:@"" message:@"已选择到最大次数"];
                return;
            }
            weakSelf.numberLabel.text = @(++newNumbet).stringValue;
            weakSelf.currentNumber = newNumbet;
            if (self.didChangeBlock) self.didChangeBlock(weakSelf);
            if (self.addChangeBlock) self.addChangeBlock(weakSelf);
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.numberLabel = [[UILabel alloc] init];
        _numberLabel.font = FONT_SIZE(18);
        _numberLabel.textColor = kColor3;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftButton.mas_right);
            make.right.equalTo(rightButton.mas_left);
            make.top.bottom.equalTo(self);
        }];
        self.currentNumber = self.minNumber;
        _numberLabel.text = @(_currentNumber).stringValue;
        
    }
    return self;
}

- (void)setMaxNumber:(NSInteger)maxNumber {
    _maxNumber = maxNumber;
    self.currentNumber = _maxNumber;
}

- (void)setMinNumber:(NSInteger)minNumber {
    _minNumber = minNumber;
    self.currentNumber = _minNumber;
}

- (void)setCurrentNumber:(NSInteger)currentNumber {
    _currentNumber = currentNumber;
    if (_numberLabel) {
        _numberLabel.text = @(_currentNumber).stringValue;
    }
    
    if (_currentNumber == 0) {
        _numberLabel.hidden = YES;
        _leftButton.hidden = YES;
    } else {
        _numberLabel.hidden = NO;
        _leftButton.hidden = NO;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
