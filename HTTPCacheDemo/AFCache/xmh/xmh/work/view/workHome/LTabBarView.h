//
//  LTabBarView.h
//  xmh
//
//  Created by ald_ios on 2018/9/11.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTabBarView : UIView
@property (nonatomic, copy)void (^TabBarViewBlock)(NSString * title);
- (void)updateTabBarViewTitles:(NSArray *)titleArr;
@end
