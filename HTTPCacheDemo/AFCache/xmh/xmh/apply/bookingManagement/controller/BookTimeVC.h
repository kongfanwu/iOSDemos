//
//  BookTimeVC.h
//  xmh
//
//  Created by ald_ios on 2018/10/22.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
@class CustomerMessageModel;
@interface BookTimeVC : BaseCommonViewController
@property (nonatomic, strong)CustomerMessageModel * customerModel;
@property (nonatomic, assign)NSInteger maxTime;
@property (nonatomic, copy) void (^BookTimeVCBlock)(NSMutableArray *selectArr,NSString *selectDate);
@end
