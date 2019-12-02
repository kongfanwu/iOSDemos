//
//  LanternSmartSearchVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  智能检索

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LanternSmartSearchVC : BaseCommonViewController
- (instancetype)initWithControllersClass:(NSArray *)controllersClass;
- (void)updateLanternSmartSearchVCIndex:(NSInteger)index searchID:(NSString *)searchID;
@end

NS_ASSUME_NONNULL_END
