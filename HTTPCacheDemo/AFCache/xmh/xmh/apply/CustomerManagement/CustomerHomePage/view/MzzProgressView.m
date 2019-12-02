//
//  MzzProgressView.m
//  test
//
//  Created by 张英杰 on 2017/12/6.
//  Copyright © 2017年 张英杰. All rights reserved.
//

#import "MzzProgressView.h"

@implementation MzzProgressView
{
    UIScrollView *_scview;
    UIImage *_img;
    UIView * _backView;
    UIView * _topView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        _scview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
//        _scview.showsHorizontalScrollIndicator = NO;
//        _img = [UIImage imageNamed:@"WechatIMG3"];
//        UIImageView *imageV = [[UIImageView alloc] initWithImage:_img];
//        imageV.frame = CGRectMake(0, 0, _img.size.width, _img.size.height);
//        [_scview addSubview:imageV];
//        _scview.contentSize = imageV.bounds.size;
//        _scview.scrollEnabled = NO;
//        [self addSubview:_scview];
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 3)];
        _backView.backgroundColor = [ColorTools colorWithHexString:@"#E5E5E5"];
        _backView.layer.cornerRadius = 2;
        [self addSubview:_backView];
        _topView = [[UIView alloc] init];
        _topView.layer.cornerRadius = 2;
        _topView.backgroundColor = [ColorTools colorWithHexString:@"#FF9072"];
        [self addSubview:_topView];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress animatied:(BOOL)animatied{
    if (animatied) {
        [UIView animateWithDuration:3 animations:^{
            _topView.frame = CGRectMake(0, 0, 70 * progress /100, 3);
        }];
    }else{
        _topView.frame = CGRectMake(0, 0, 70 * progress/100, 3);
    }
    
}
@end
