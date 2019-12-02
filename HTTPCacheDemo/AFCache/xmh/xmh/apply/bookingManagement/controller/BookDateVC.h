//
//  BookDateVC.h
//  xmh
//
//  Created by ald_ios on 2018/10/23.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
@interface BookDateVC : BaseCommonViewController
@property (nonatomic, copy) void (^BookDateVCBlock)(NSString * date);
@property (nonatomic, copy)NSString * selectDate;
@end
