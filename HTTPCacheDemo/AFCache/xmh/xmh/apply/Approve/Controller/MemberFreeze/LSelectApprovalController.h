//
//  LSelectApprovalController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSponsorApproceModel.h"
#import "BaseCommonViewController.h"
@interface LSelectApprovalController : BaseCommonViewController
@property (strong, nonatomic)NSArray<LApprocePersonModel *> *approcePersonList;
@property (copy, nonatomic)void (^LSelectApprovalControllerBlock)(LApprocePersonModel * model);
@end
