//
//  UIView+XMHXIBProperty.h
//  xmh
//
//  Created by KFW on 2019/4/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//


#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XMHXIBProperty)

/** 圆角 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/** 裁剪 */
@property (nonatomic, assign) IBInspectable BOOL maskToBounds;
/** border 宽 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/** border 颜色 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end

NS_ASSUME_NONNULL_END
