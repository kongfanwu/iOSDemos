//
//  XMHFormEndTypeAlertVC.h
//  xmh
//
//  Created by kfw on 2019/6/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormEndTypeAlertVC : UIViewController

/** <#type#> */
@property (nonatomic, copy) void (^didFinishBlock)(NSString *ID);

@end

NS_ASSUME_NONNULL_END
