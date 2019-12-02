//
//  XMHCredentiaManageVenditionStateView.h
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHCredentiaOrderStateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHCredentiaManageVenditionStateView : UIView
/** <##> */
@property (nonatomic, strong) NSArray <XMHCredentiaOrderStateItemModel *>* stateArrray;

/** <#type#> */
@property (nonatomic, copy) void (^didSelectBlock)(XMHCredentiaManageVenditionStateView *view, XMHCredentiaOrderStateItemModel *credentiaOrderStateItemModel);
@end

NS_ASSUME_NONNULL_END
