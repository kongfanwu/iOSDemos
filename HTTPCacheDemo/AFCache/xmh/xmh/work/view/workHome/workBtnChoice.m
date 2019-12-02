//
//  workBtnChoice.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/3.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "workBtnChoice.h"
#import "ShareWorkInstance.h"

@implementation workBtnChoice{
    
    UIImageView *_line;
    UIImageView *_linedark;
    CGFloat  _btnWith;
    NSMutableArray *_btnArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews{
    self.backgroundColor = [UIColor whiteColor];
    NSArray *arrtitle = @[@"待预约",@"待审批",@"待服务",@"待跟进"];
    _btnWith = self.width/arrtitle.count;
    NSInteger i = 0;
    
    _linedark = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height - 1,self.width, 1)];
    _linedark.backgroundColor= kBackgroundColor;
    [self addSubview:_linedark];
    
    _btnArr = [[NSMutableArray alloc]init];
    
    NSUInteger haveTag = 1000;
    if ([ShareWorkInstance shareInstance].btnTag) {
        haveTag = [ShareWorkInstance shareInstance].btnTag;
    }
    for (NSString *title in arrtitle) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_btnWith)*i,0, _btnWith, 49)];
        btn.tag = 1000+i;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateSelected];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [btn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
        btn.titleLabel.font = FONT_SIZE(13);
        [self addSubview:btn];
        if (haveTag == btn.tag) {
            btn.selected = YES;
            _line = [[UIImageView alloc]initWithFrame:CGRectMake(_btnWith *(haveTag - 1000), self.height - 3, _btnWith, 2)];
            _line.backgroundColor= [ColorTools colorWithHexString:@"#f10180"];
            [self addSubview:_line];
        }
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [_btnArr addObject:btn];
    }
}
- (void)btnEvent:(UIButton *)sender{
    [ShareWorkInstance shareInstance].btnTag = sender.tag;
    for (UIButton *btnTemp in _btnArr) {
            btnTemp.selected = NO;
    }
    sender.selected = YES;
    _line.frame = CGRectMake(_btnWith * (sender.tag - 1000), self.height - 3, _btnWith, 2);
    if (_workBtnChoiceBlock) {
        _workBtnChoiceBlock(sender.titleLabel.text);
    }
}
@end
