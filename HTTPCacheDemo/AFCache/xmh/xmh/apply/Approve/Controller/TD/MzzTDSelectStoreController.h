//
//  MzzTDSelectStoreController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"

@class SPStoresModel;
@interface MzzTDSelectStoreController : BaseCommonViewController
@property (nonatomic ,copy)void (^sureOnclick)(SPStoresModel * model);
@end
