//
//  XMHSharedAlertVC.h
//  xmh
//
//  Created by KFW on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHSharedAlertVC : UIViewController
/** <##> */
@property (nonatomic, copy) NSString *shareUrl;
/** <#type#> */
@property (nonatomic, copy) void (^shareResultBlock)(BOOL cuccess);
@end

NS_ASSUME_NONNULL_END
