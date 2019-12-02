//
//  XMHCouponListConst.h
//  xmh
//
//  Created by shendengmeiye on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#ifndef XMHCouponListConst_h
#define XMHCouponListConst_h
/**
 创建订单类型
 */
typedef NS_ENUM(NSInteger, XMHCounponFunctionType) {
    XMHCounponFunctionTypeTingYong, // 停用
    XMHCounponFunctionTypeQiYong, // 启用
    XMHCounponFunctionTypeXiuGai, // 修改
    XMHCounponFunctionTypeXiuGaiKuCun, // 修改库存
    XMHCounponFunctionTypeShare, //分享
    XMHCounponFunctionTypeDelete, // 删除
};
#endif /* XMHCouponListConst_h */
