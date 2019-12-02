//
//  BeautyCFBiaoSelectView.h
//  xmh
//
//  Created by ald_ios on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeautyCFBiaoSelectView : UIView
@property (nonatomic, copy) void (^BeautyCFBiaoSelectViewStoreBlock)();
@property (nonatomic, copy) void (^BeautyCFBiaoSelectViewDateBlock)();
- (void)updateBeautyCFBiaoSelectViewLeftTitle:(NSString *)leftTitle;
- (void)updateBeautyCFBiaoSelectViewDate:(NSString *)date;
@end

NS_ASSUME_NONNULL_END
