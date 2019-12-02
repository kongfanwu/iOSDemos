//
//  MzzFilterTbSectionHeaderViewCommon.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/28.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzFilterTbSectionHeaderViewCommon.h"

@implementation MzzFilterTbSectionHeaderViewCommon

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    _tap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:_tap];
}
@end
