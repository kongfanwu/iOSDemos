//
//  LFreezeQueryMemberView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFreezeQueryMemberView.h"

@implementation LFreezeQueryMemberView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    _btnQuery.layer.cornerRadius = 3;
    _btnQuery.layer.masksToBounds = YES;
    
    _tfQuery.layer.cornerRadius = 3;
    _tfQuery.layer.masksToBounds = YES;
    
    _tfQuery.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _tfQuery.leftViewMode = UITextFieldViewModeAlways;
}
@end
