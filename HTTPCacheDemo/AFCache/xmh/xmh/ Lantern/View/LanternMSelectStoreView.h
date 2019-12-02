//
//  LanternMSelectStoreView.h
//  xmh
//
//  Created by ald_ios on 2019/2/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMSelectStoreView : UIView
@property (nonatomic, copy)void (^LanternMSelectStoreViewBlock)(NSMutableArray *param);
@property (nonatomic, copy)void (^LanternMSelectStoreViewSearchBlock)(NSString *key);
- (void)updateSelectViewPlaceHolder:(NSString *)placeholder;
- (void)updateViewParam:(NSMutableArray *)param;
@end

NS_ASSUME_NONNULL_END
