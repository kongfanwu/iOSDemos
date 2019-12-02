//
//  ApproveDetailController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
#import "ApproveDetailModel.h"
@interface ApproveDetailController : BaseCommonViewController
@property (nonatomic, strong)ApproveDetailModel * detailModel;
@property (nonatomic, copy)NSString * store_code;
@end
