//
//  UIView+FWScreenshot.h
//  XLoongGlass
//
//  Created by 孔凡伍 on 16/8/11.
//  Copyright © 2016年 kongfanwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FWScreenshot)
- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;
@end
