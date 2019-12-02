//
//  navLeftBtn.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "navLeftBtn.h"

@implementation navLeftBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    
    _lb1 =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.width - 20, 20)];
    _lb1.text = @"蒂洛斯...";
    _lb1.textColor = [UIColor darkGrayColor];
    _lb1.font = FONT_SIZE(13);
    [self addSubview:_lb1];
    
    _imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 20, 10, 20, 20)];
    [self addSubview:_imageview1];
}

- (void)reloadnavLeftBtn:(NSString *)leftTitleStr{
    _lb1.text= leftTitleStr;
//    _imageview1.image =
}
@end
