//
//  BeautyGWCCommitTopView.h
//  xmh
//
//  Created by ald_ios on 2019/5/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeautyGWCCommitTopView : UIView
@property (nonatomic, copy) void (^BeautyGWCCommitTopViewBlock)();
- (void)updateBeautyGWCCommitTopViewTitle:(NSString *)title;
- (void)updateTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
