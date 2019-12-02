//
//  LanternRecommendFootView.h
//  xmh
//
//  Created by ald_ios on 2018/12/27.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanternRecommendFootView : UIView
@property (nonatomic, copy)void (^LanternRecommendFootViewBlock)(NSString * type);
- (void)updateLanternRecommendFootViewLeftEnable:(NSString *)leftenable rightEnable:(NSString *)rightenable;
- (void)updateLanternRecommendFootViewMonth:(NSString *)month;
@end
