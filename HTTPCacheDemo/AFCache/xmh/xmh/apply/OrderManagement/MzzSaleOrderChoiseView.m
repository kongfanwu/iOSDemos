//
//  MzzSaleOrderChoiseView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/4/28.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzSaleOrderChoiseView.h"

@implementation MzzSaleOrderChoiseView

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
