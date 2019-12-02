//
//  LDeatailSelectView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/4.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LDeatailSelectView.h"

@implementation LDeatailSelectView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _btnCancel.layer.borderWidth = 1;
    _btnCancel.layer.borderColor = kBtn_Commen_Color.CGColor;
    _btnCancel.layer.cornerRadius  = 2;
    _btnCancel.layer.masksToBounds = YES;
}
@end
