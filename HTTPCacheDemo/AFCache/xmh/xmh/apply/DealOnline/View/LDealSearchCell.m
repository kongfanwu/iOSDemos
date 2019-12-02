//
//  LDealSearchCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDealSearchCell.h"
#import "JasonSearchView.h"
@implementation LDealSearchCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews
{
    UIView * line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    line.backgroundColor = kBackgroundColor;
    [self.contentView addSubview:line];
    JasonSearchView * searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, line.bottom, SCREEN_WIDTH, 45)withPlaceholder:@"姓名/手机号"];
    [self.contentView addSubview:searchView];
}
@end
