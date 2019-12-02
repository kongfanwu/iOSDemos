//
//  MzzPujiButton.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzPujiButton.h"

@implementation MzzPujiButton


- (void)drawRect:(CGRect)rect {
    [self.layer setCornerRadius:5];
    self.layer.masksToBounds = YES;
    [self.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    [self.layer setBorderWidth:1.0];
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        if (_selectColor) {
             [self.layer setBorderColor:_selectColor.CGColor];
        }else{
            [self.layer setBorderColor:kBtn_Commen_Color.CGColor];
        }
    }else{
          [self.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    }
}

@end
