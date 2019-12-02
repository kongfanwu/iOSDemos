//
//  GKGLBillVerifyVC.h
//  xmh
//
//  Created by ald_ios on 2019/1/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"
#import "CustomerListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKGLBillVerifyVC : BaseCommonViewController
@property (strong, nonatomic)CustomerModel * customerModel;
@property (nonatomic,strong)NSMutableDictionary *paramDic;
@end

NS_ASSUME_NONNULL_END
