//
//  XMHShoppingCart.h
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 购物车

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,ShoppingCartEenterType) {
    
    ShoppingCartEenterType_Default,
    ShoppingCartEenterType_BillRec,//回收置换
    ShoppingCartEenterType_SaleOrder,
};

@interface XMHShoppingCartView : UIView
/** 是否可编辑，默认YES */
@property (nonatomic) BOOL isEdit;
/** 购物车按钮文案,默认"去支付" */
@property (nonatomic,copy)NSString *submitButtonTitle;
/** 购物车入口.体验制单/回收置换*/
@property (nonatomic, assign) ShoppingCartEenterType enterType;

//TODO 暂时这样加
@property (nonatomic, copy)void (^shoppingCart)(NSMutableArray *modelArr);
@end

NS_ASSUME_NONNULL_END
