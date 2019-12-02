//
//  UIView+Exting.h
//  iLoan
//
//  Created by kubook008 kubook008 on 15/9/21.
//  Copyright © 2015年 51credit.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Exting)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

- (void)removeAllSubViews;
@end
