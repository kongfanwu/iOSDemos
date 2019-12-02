//
//  OneDateCollectionViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OneDateCollectionViewCell.h"

@implementation OneDateCollectionViewCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews{
    _lb = [[UILabel alloc] init];
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.font = FONT_SIZE(13);
    _lb.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lb];
}
- (void)updateOneDateCollectionViewCell:(NSString *)title{
    
    _lb.text = title;
    [_lb sizeToFit];
    _lb.frame = CGRectMake(0, 0, self.width, self.height);
   
}

@end
