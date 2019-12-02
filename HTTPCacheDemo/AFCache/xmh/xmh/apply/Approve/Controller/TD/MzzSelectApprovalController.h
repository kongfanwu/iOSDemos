//
//  MzzSelectApprovalController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/7.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGetTdPersonModel.h"
#import "BaseCommonViewController.h"

@interface MzzSelectApprovalController : BaseCommonViewController
@property (strong, nonatomic)NSArray<SPPersonModel *> *approcePersonList;
@property (copy, nonatomic)void (^LSelectApprovalControllerBlock)(SPPersonModel * model);
@end
