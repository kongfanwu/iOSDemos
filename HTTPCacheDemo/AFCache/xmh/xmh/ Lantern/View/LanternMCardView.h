//
//  LanternMCardView.h
//  xmh
//
//  Created by ald_ios on 2019/3/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMCardView : UIView
@property (nonatomic, copy)void (^LanternMCardViewSureBlock)(NSMutableArray *param);
- (void)updateViewParam:(NSMutableArray *)param;
@end

NS_ASSUME_NONNULL_END
