//
//  XMHServiceOrderProjectGoodTableView.h
//  xmh
//
//  Created by KFW on 2019/3/26.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHBaseTableView.h"
#import "XMHServiceProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHServiceOrderProjectGoodTableView : XMHBaseTableView

/** <##> */
@property (nonatomic, strong) NSArray *modelArray;
/** 购物车添加商品回调  return yes 可以添加 no 不可以，库存不足
    卡卷类的限制方式。总数在卡卷model里
 */
@property (nonatomic, copy) BOOL (^shoppingCartAddModelBlcok)(XMHServiceProjectModel *model);

@end

NS_ASSUME_NONNULL_END
