//
//  workSecondBtnChoice.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "workSecondBtnChoice.h"
#import "ShareWorkInstance.h"

@implementation workSecondBtnChoice{
    
    UIImageView *_line;
    UIImageView *_linedark;
    CGFloat  _btnWith;
    NSArray *_titleArr;
    NSMutableArray *_btnArr;
    BOOL _isFuWu;
}
- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray *)titleArr withFuWu:(BOOL)isFuWu{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArr = titleArr;
        _isFuWu = isFuWu;
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    _btnWith = self.width/_titleArr.count;
    NSInteger i = 0;
    
    _linedark = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height - 1,self.width, 1)];
    _linedark.backgroundColor= kBackgroundColor;
    [self addSubview:_linedark];
    
    _btnArr = [[NSMutableArray alloc]init];
    
    NSUInteger secondhaveTag = 1000;
    NSUInteger thirdhaveTag = 1000;
    if (_isFuWu) {
        if ([ShareWorkInstance shareInstance].SecondBtnTag) {
            secondhaveTag = [ShareWorkInstance shareInstance].SecondBtnTag;
        }
    } else {
        if ([ShareWorkInstance shareInstance].ThirdBtnTag) {
            thirdhaveTag = [ShareWorkInstance shareInstance].ThirdBtnTag;
        }
    }
    for (NSString *title in _titleArr) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_btnWith)*i,0, _btnWith, 49)];
        btn.tag = 1000+i;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateSelected];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [btn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
        btn.titleLabel.font = FONT_SIZE(13);
        [self addSubview:btn];
        if (_isFuWu) {
            if (secondhaveTag == btn.tag) {
                btn.selected = YES;
                _line = [[UIImageView alloc]initWithFrame:CGRectMake(_btnWith *(secondhaveTag - 1000), self.height - 3, _btnWith, 2)];
                _line.backgroundColor= [ColorTools colorWithHexString:@"#f10180"];
                [self addSubview:_line];
            }
        } else {
            if (thirdhaveTag == btn.tag) {
                btn.selected = YES;
                _line = [[UIImageView alloc]initWithFrame:CGRectMake(_btnWith *(thirdhaveTag - 1000), self.height - 3, _btnWith, 2)];
                _line.backgroundColor= [ColorTools colorWithHexString:@"#f10180"];
                [self addSubview:_line];
            }
        }
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [_btnArr addObject:btn];
    }
}
- (void)btnEvent:(UIButton *)sender{
    if (_isFuWu) {
        [ShareWorkInstance shareInstance].SecondBtnTag = sender.tag;
    } else {
        [ShareWorkInstance shareInstance].ThirdBtnTag = sender.tag;
    }
    for (UIButton *btnTemp in _btnArr) {
        btnTemp.selected = NO;
    }
    sender.selected = YES;
    _line.frame = CGRectMake(_btnWith * (sender.tag - 1000), self.height - 3, _btnWith, 2);
    if (_workSecondBtnChoiceBlock) {
        _workSecondBtnChoiceBlock(sender.titleLabel.text);
    }
}

@end
