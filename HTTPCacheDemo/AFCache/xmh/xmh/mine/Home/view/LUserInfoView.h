//
//  LUserInfoView.h
//  xmh
//
//  Created by ald_ios on 2018/9/7.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineTopModel;
@interface LUserInfoView : UIView
@property (nonatomic, copy) void (^UserInfoViewBlock)();
+ (instancetype)loadUserInfoView;
- (void)updateUserInfoViewModel:(MineTopModel*)model;
@end
