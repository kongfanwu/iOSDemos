//
//  XMHFormDataCreate.h
//  xmh
//
//  Created by KFW on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHCouponModel.h"
#import "XMHFormModel.h"
#import "XMHFormSectionModel.h"
#import "XMHItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormDataCreate : NSObject
/** 优惠券详情model */
@property (nonatomic, strong) XMHCouponModel *couponModel;
/** <##> */
@property (nonatomic, strong) NSMutableArray *formListArray;

/**
 创建现金劵
 */
- (NSMutableArray *)createFormListCouponModel:(XMHCouponModel *)couponModel edit:(BOOL)edit createType:(XMHActionCreateType)createType;

/**
 创建折扣劵
 */
- (NSMutableArray *)createFormZheKouListCouponModel:(XMHCouponModel *)couponModel edit:(BOOL)edit createType:(XMHActionCreateType)createType;

/**
 创建礼品劵
 */
- (NSMutableArray *)createFormLiPinListCouponModel:(XMHCouponModel *)couponModel edit:(BOOL)edit createType:(XMHActionCreateType)createType;

/**
 根据 serviceKey 寻找 _formListArray XMHFormModel
 
 @param serviceKey XMHFormModel 属性
 @return XMHFormModel
 */
- (XMHFormModel *)formModelfromServiceKey:(NSString *)serviceKey;

/**
 优惠券类型集合
 */
+ (NSArray <XMHItemModel *>*)couponTypeListBlcok:(nullable void(^)(XMHItemModel *itemModel))block;

/**
 获取优惠券使用条件集合
 */
+ (NSArray <XMHItemModel *>*)limitTypeList;

/**
 获取优惠券发放条件集合
 */
+ (NSArray <XMHItemModel *>*)sendLimitList;
/**
 使用渠道
 */
+ (NSArray <XMHItemModel *>*)platformList;

/**
 拼接 服务端所需要的store_code 字段
 
 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSMutableArray *)getStoreCodeFormModel:(XMHFormModel *)formMdoel;

/**
 拼接 服务端 会员等级数据
 
 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSString *)getVipLevelFormModel:(XMHFormModel *)formMdoel;

/**
 拼接 订单商品 数据
 
 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSString *)getOrderGoodsFormModel:(XMHFormModel *)formMdoel;

/**
 拼接 使用渠道 数据
 
 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSString *)getPlatformFormModel:(XMHFormModel *)formMdoel;

/**
 校验必填项
 return YES 通过 NO 未通过
 */
+ (BOOL)checkMustParamFormModel:(XMHFormModel *)formModel block:(void(^)(NSString *des))block;

@end

NS_ASSUME_NONNULL_END
