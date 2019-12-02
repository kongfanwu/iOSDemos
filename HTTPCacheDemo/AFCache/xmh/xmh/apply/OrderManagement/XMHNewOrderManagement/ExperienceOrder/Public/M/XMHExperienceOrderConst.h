//
//  XMHExperienceOrderConst.h
//  xmh
//
//  Created by KFW on 2019/3/21.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 订单管理 全局枚举 宏 常量文件

#ifndef XMHExperienceOrderConst_h
#define XMHExperienceOrderConst_h

/**
 订单类型
 */
typedef NS_ENUM(NSInteger, XMHCreateOrderType) {
    XMHCreateOrderTypeExperience = 100, // 体验订单
    XMHCreateOrderTypeService,    // 服务单
//    XMHCreateOrderTypeSales, // 销售单
};

/**
 体验订单 - 服务类型
 */
typedef NS_ENUM(NSInteger, XMHExperienceOrderType) {
    XMHExperienceOrderTypeProject = 200,   // 项目服务
    XMHExperienceOrderTypeGoods,     // 产品服务
    XMHExperienceOrderTypeExperience,// 体验服务
};

/**
 服务类型
 */
typedef NS_ENUM(NSInteger, XMHServiceOrderType) {
    XMHServiceOrderTypeChuFang = 300, // 处方
    XMHServiceOrderTypeProject, // 项目
    XMHServiceOrderTypeGoods,   // 产品
    XMHServiceOrderTypeTiKaStordeCar, // 储值卡
    XMHServiceOrderTypeTiKaNumCar, // 任选卡
    XMHServiceOrderTypeTiKaTimeCar, // 时间卡
    
    XMHServiceOrderTypeTiKaTeHui, // 特惠卡
    XMHServiceOrderTypePiaoJuan, // 票劵
    XMHServiceOrderTypeXuKaChongZhi, // 续卡充值
};

/**
 凭证管理 - 凭证类型
 */
typedef NS_ENUM(NSInteger, XMHCredentiaItemViewType) {
    XMHCredentiaItemViewTypeVendition, // 销售凭证
    XMHCredentiaItemViewTypeService, // 服务凭证
};


/**
 H5 类型
 */
typedef NS_ENUM(NSUInteger){
    YemianXiangQing,
    YemianJieSuan,
    YemianHuanKuan,
    YemianZhongZhi,
    YemianBuQian,
    YemianFenQi,
    YemianFenQiXiangQing
    
}YemianStyle;

/**
 订单功能枚举
 */
typedef NS_ENUM(NSInteger, XMHOrderFunctionType) {
    XMHOrderFunctionTypePay, // 支付
    XMHOrderFunctionTypeLookZhangDan, // 查看账单
    XMHOrderFunctionTypeCheXiao, // 撤销
    XMHOrderFunctionTypeBuQiXiangMu, // 补齐项目
    XMHOrderFunctionTypeBuQiYeJi, // 补齐业绩
    XMHOrderFunctionTypeZhongZhi, // 终止
    XMHOrderFunctionTypeHuanKuan, // 还款
    
    XMHOrderFunctionTypeJieSuan, // 结算
    XMHOrderFunctionTypeFuWuJiLu, // 服务记录
    XMHOrderFunctionTypeShare, // 分享
};

/**
 回收置换 - 类型
 */
typedef NS_ENUM(NSInteger, XMHBillRecoverType) {
    XMHBillRecoverTypeTicket = 100, // 票券
    XMHBillRecoverTypeTimeCar, // 时间卡
    XMHBillRecoverTypeNumCar, // 任选卡
    XMHBillRecoverTypeStordeCar, // 储值卡
    XMHBillRecoverTypeGoods,   // 产品
    XMHBillRecoverTypePro, // 项目

};

/**
 销售单 - 类型
 */
typedef NS_ENUM(NSInteger, XMHSaleOrderType) {
    XMHSaleOrderTypeTicket = 100, // 票券
    XMHSaleOrderTypeTimeCar, // 时间卡
    XMHSaleOrderTypeNumCar, // 任选卡
    XMHSaleOrderTypeStordeCar, // 储值卡
    XMHSaleOrderTypeGoods,   // 产品
    XMHSaleOrderTypePro, // 项目
    XMHSaleOrderTypeXukaCar, // 续卡
    XMHSaleOrderTypeTehuiCar, // 特惠卡
    
};

/**
 活动中心 - 优惠票卷类型
 */
typedef NS_ENUM(NSInteger, XMHActionCouponType) {
    /** 类型 3:现金券 4：折扣券 5：礼品券 与服务端对应*/
    XMHActionCouponTypeXianJin = 3, // 现金卷
    XMHActionCouponTypeZheKou = 4, // 折扣卷
    XMHActionCouponTypeLiPin = 5, // 礼品卷
    
};

/**
 活动中心 - 创建票卷类型
 */
typedef NS_ENUM(NSInteger, XMHActionCreateType) {
    XMHActionCreateTypeCreate, // 创建
    XMHActionCreateTypeEdit, // 修改
    XMHActionCreateTypeChaKan, // 查看
    
};
#endif /* XMHExperienceOrderConst_h */
