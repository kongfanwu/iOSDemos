//
//  UIViewController+XMHAdditions.h
//  xmh
//
//  Created by kfw on 2019/6/24.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XMHAdditions)

/**
 从navagation搜索VC
 */
- (UIViewController *)searchNavigationStackClassVC:(Class)vcCls;

/**
 从navagation搜索VC
 */
- (UIViewController *)searchNavigationStackStringVC:(NSString *)vcStr;

@end

NS_ASSUME_NONNULL_END
