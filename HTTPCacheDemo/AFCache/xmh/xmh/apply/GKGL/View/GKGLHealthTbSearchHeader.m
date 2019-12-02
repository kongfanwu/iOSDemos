//
//  GKGLHealthTbSearchHeader.m
//  xmh
//
//  Created by ald_ios on 2019/1/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "GKGLHealthTbSearchHeader.h"
@interface GKGLHealthTbSearchHeader ()

@end
@implementation GKGLHealthTbSearchHeader

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)];
    [self addGestureRecognizer:tap];
}
- (void)tapDown:(UITapGestureRecognizer *)tap
{
    if (_GKGLHealthTbSearchHeaderTapBlock) {
        _GKGLHealthTbSearchHeaderTapBlock();
    }
}
@end
