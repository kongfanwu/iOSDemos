//
//  BeautyDesignRightSectionHeader.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyDesignRightSectionHeader.h"

@implementation BeautyDesignRightSectionHeader
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];

}
- (void)freshBeautyDesignRightSectionHeader:(NSString *)str1 withstr2:(NSString *)str2{
    _lb1.text = str1;
    [_lb1 sizeToFit];
    
    _lb2.text = str2;
    [_lb2 sizeToFit];
    _lb2.adjustsFontSizeToFitWidth = YES;

}
@end
