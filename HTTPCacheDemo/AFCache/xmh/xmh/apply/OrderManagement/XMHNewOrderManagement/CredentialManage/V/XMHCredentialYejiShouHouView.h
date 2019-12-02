//
//  XMHCredentialYejiShouHouView.h
//  xmh
//
//  Created by KFW on 2019/4/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 业绩售后view

#import <UIKit/UIKit.h>
#import "XMHCredentiaOrderStateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentialYejiShouHouView : UIView

/** <##> */
@property (nonatomic, strong) NSArray <XMHCredentiaOrderStateItemModel *> *dataArray;

/** <#type#> */
@property (nonatomic, copy) void (^didSelectBlock)(XMHCredentialYejiShouHouView *view, XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel);


/** 标识选中model */
@property (nonatomic, strong) XMHCredentiaOrderStateItemModel *selectMdoel;
@end

NS_ASSUME_NONNULL_END
