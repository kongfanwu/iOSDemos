//
//  OrderChoiseView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "OrderChoiseView.h"

@implementation OrderChoiseView

- (IBAction)btnEvent:(UIButton *)sender {
    for (UIView *tempView in self.subviews) {
        if ([tempView isKindOfClass:[UIButton class]]) {
            if (tempView.tag == sender.tag) {
                sender.selected = YES;
                _redLine.center = CGPointMake(sender.center.x, _redLine.center.y);
                if (_OrderChoiseViewBlock) {
                    _OrderChoiseViewBlock(sender.tag - 1000);
                }
            } else {
                UIButton *temp = (UIButton *)tempView;
                temp.selected = NO;
            }
        }
    }
}

@end
