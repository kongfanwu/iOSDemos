//
//  XMHMarketVC.h
//  xmh
//
//  Created by ald_ios on 2019/5/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "XMHMarketEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHMarketVC : BaseCommonViewController
@property (nonatomic, assign)XMHMarketVCType marketVCType;
@property (nonatomic, copy)NSString * navtitle;
@end

NS_ASSUME_NONNULL_END
