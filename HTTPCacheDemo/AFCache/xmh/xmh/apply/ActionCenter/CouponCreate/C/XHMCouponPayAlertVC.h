//
//  XHMCouponPayAlertVC.h
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCouponPayInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XHMCouponPayAlertVC : UIViewController

/** <##> */
@property (nonatomic, copy) NSString *titleStr;
/** 支付详情 */
@property (nonatomic, strong) XMHCouponPayInfoModel *payModel;
/**
 回调
 param： isAction YES:激活可使用 NO:不激活可使用
 */
@property (nonatomic, copy) void (^selectBlock)(BOOL isAction, CGFloat price);

@end

NS_ASSUME_NONNULL_END
