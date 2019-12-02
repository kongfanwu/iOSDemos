//
//  LTabTwoView.h
//  xmh
//
//  Created by ald_ios on 2018/9/11.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTabTwoView : UIView
- (void)updateTabTwoViewTitles:(NSArray *)titleArr;
@property (nonatomic, copy)void (^TabTwoViewBlock)(NSString * title);
@end
