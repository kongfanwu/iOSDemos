//
//  XMHBillRecContentVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// 通知key, 增、删、重新计算价格，都会触发通知
UIKIT_EXTERN NSString * const kXMHShoppingCartUpdateNotification;
typedef void(^AddToShoppingCartBlock)(id model);

@interface XMHBillRecContentVC : UIViewController

@property (nonatomic, copy)AddToShoppingCartBlock addShoppingCartBlock;
/** */
@property (nonatomic, strong) UINavigationController *nav;

- (instancetype)initUserId:(NSString *)userId type:(NSString *)type name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
