//
//  LanternRecommendSwtichView.h
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanternRecommendSwtichView : UIView
@property (nonatomic, copy) void (^LanternRecommendSwtichViewBlock)(NSUInteger tag);
@end
