//
//  XMHCredentiaManageVenditionVC.h
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 销售权限

#import "BaseCommonViewController.h"
#import "BaseViewController1.h"
#import "XMHShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaManageVenditionVC : BaseCommonViewController
/** <##> */
@property (nonatomic, strong) XMHShopModel *shopModel;
/** 岗位id */
@property (nonatomic, copy) NSString *fram_id;
@end

NS_ASSUME_NONNULL_END
