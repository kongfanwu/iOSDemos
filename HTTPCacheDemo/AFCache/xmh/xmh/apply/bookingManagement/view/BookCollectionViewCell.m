//
//  BookCollectionViewCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BookCollectionViewCell.h"

@implementation BookCollectionViewCell

- (void)layoutSubviews{
    [super layoutSubviews];
    _img = [[UIImageView alloc] init];
    _img.frame = CGRectMake(7, 10, 40, 40);
    _img.layer.cornerRadius = 20;
    _img.layer.masksToBounds = YES;
    _img.backgroundColor = [UIColor redColor];
    [self addSubview:_img];
    
    _lb = [[UILabel alloc] init];
    _lb.text = @"全部";
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.font = FONT_SIZE(10);
    [_lb sizeToFit];
    _lb.frame = CGRectMake(0, _img.bottom + 5, self.width, _lb.height);
    [self addSubview:_lb];
}
- (void)updateBookCollectionViewCell{
    
   
    
}
@end
