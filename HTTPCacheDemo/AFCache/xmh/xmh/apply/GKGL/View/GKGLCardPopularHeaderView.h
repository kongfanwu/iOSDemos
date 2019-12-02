//
//  GKGLCardPopularHeaderView.h
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLCardPopularHeaderView : UICollectionReusableView
@property (nonatomic, copy)void (^GKGLCardPopularHeaderViewTapBlock)(NSInteger index);
- (void)updateGKGLCardPopularHeaderViewTitleIndex:(NSInteger)index;
/** 问诊详情刷新 */
- (void)updateGKGLCardPopularHeaderViewFromHealthInquiryTitle:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
