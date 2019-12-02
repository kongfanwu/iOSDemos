//
//  XMHSelectJiShiVC.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 选择技师

#import <UIKit/UIKit.h>
#import "MLJishiSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHSelectJiShiVC : UIViewController
/** <#type#> */
@property (nonatomic, copy) void (^selectBlock)(XMHSelectJiShiVC *vc, MLJiShiModel *jiShiModel);
@end

NS_ASSUME_NONNULL_END
