//
//  GKGLHomeTopView.h
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLHomeTopView : UIView
/** 添加顾客回调 */
@property (nonatomic, copy)void (^GKGLHomeTopViewAddBlock)();
/** 数据统计回调 */
@property (nonatomic, copy)void (^GKGLHomeTopViewDataBlock)();
@end

NS_ASSUME_NONNULL_END
