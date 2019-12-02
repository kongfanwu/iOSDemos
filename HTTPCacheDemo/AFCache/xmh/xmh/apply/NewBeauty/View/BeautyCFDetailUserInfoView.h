//
//  BeautyCFDetailUserInfoView.h
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeautyCFDetailUserInfoView : UIView
/** 删除处方 */
@property(nonatomic, copy)void (^BeautyCFDetailUserInfoViewDelBlock)(NSMutableDictionary *param);
/** 结束处方 */
@property(nonatomic, copy)void (^BeautyCFDetailUserInfoViewEndBlock)(NSMutableDictionary *param);
/** 继续开单 */
@property(nonatomic, copy)void (^BeautyCFDetailUserInfoViewContinueBlock)(NSMutableDictionary *param);
- (void)updateViewParam:(NSMutableDictionary *)param;
@end

NS_ASSUME_NONNULL_END
