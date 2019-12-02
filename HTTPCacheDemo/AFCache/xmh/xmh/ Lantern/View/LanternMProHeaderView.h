//
//  LanternMProHeaderView.h
//  xmh
//
//  Created by ald_ios on 2019/2/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMProHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (nonatomic, copy)void (^LanternMProHeaderViewTapBlock)(NSInteger index);
@property (nonatomic, copy)void (^LanternMProHeaderViewClickBlock)(NSMutableDictionary * param);
/** 弹窗的回调 */
@property (nonatomic, copy)void (^LanternMProHeaderViewMoreBlock)(NSMutableDictionary * param);
- (void)updateViewParam:(NSMutableDictionary *)param;
- (void)updateViewParam:(NSMutableDictionary *)param module:(NSInteger)module;
- (void)updateViewParam:(NSMutableDictionary *)param section:(NSInteger)section module:(NSInteger)module;
@end

NS_ASSUME_NONNULL_END
