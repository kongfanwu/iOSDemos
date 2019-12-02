//
//  XMHShoppingCartDetailView.h
//  xmh
//
//  Created by KFW on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 购物车详情列表

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ShoppingCartCellType) {
    
    ShoppingCartCellType_Default = 0,
    ShoppingCartCellType_BillRec = 1,//回收置换
    ShoppingCartCellType_SaleOrder = 2,//销售制单
};

NS_ASSUME_NONNULL_BEGIN

@interface XMHShoppingCartDetailView : UIView
/** <##> */
@property (nonatomic, strong, nullable) NSArray *dataArray;
/** <##> */
@property (nonatomic, assign) ShoppingCartCellType cellType;
/** <#type#> */
@property (nonatomic, copy) void (^removeSuperViewBlock)();
@end

NS_ASSUME_NONNULL_END
