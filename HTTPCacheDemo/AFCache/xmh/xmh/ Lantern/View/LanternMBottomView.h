//
//  LanternMBottomView.h
//  xmh
//
//  Created by ald_ios on 2019/2/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMBottomView : UIView
@property (nonatomic, copy)void (^LanternMBottomViewResetBlock)();
@property (nonatomic, copy)void (^LanternMBottomViewSearchBlock)();
@property (nonatomic, assign)NSInteger index;
- (void)updateTitleLeft:(NSString *)left right:(NSString *)right;
@end

NS_ASSUME_NONNULL_END
