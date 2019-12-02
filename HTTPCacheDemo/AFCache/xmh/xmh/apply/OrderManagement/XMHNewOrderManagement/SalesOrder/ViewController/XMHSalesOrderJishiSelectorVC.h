//
//  XMHSalesOrderJishiSelectorVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLJiShiModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSalesOrderJishiSelectorVC : UIViewController
/** <#type#> */
@property (nonatomic, copy) void (^selectBlock)(XMHSalesOrderJishiSelectorVC *vc, MLJiShiModel *jiShiModel);
@end

NS_ASSUME_NONNULL_END
