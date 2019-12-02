//
//  XMHFormModel.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHItemModel.h"
#import "XMHCouponPayInfoModel.h"

typedef NS_ENUM(NSInteger, XMHFormType) {
    XMHFormTypeDefault = 1, // 左title 右文本输入框，非编辑状态下显示单行文本
    XMHFormTypeInputTextField, // 左title 右输入框。  此类型如果 valueType 有值，会显示。
    XMHFormTypeImage, // 选择图片
    XMHFormTypeInputTextView, // 左title 下输入框
    XMHFormTypeDateStartEnd, // 开始 结束时间
    XMHFormTypeSelect, // 选择类型,非编辑状态，显示箭头，value描述.   XMHFormTypeSelect XMHFormTypeSelectNoEditContentFilled 编辑状态一样，非编辑状态不同
    XMHFormTypeSelectNoEditContentFilled, // 选择类型,非编辑状态，无箭头，value描述充满
    XMHFormTypeDiscount, // 打折类型
    XMHFormTypeCoupon, // 优惠卷类型
    XMHFormTypeContentFilled, // 左title 右文本
};

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormModel : NSObject
/** 表单类型 */
@property (nonatomic) XMHFormType type;
/** 是否可编辑 默认yes */
@property (nonatomic) BOOL isEdit;
/** 是否必填 默认NO */
@property (nonatomic) BOOL isMust;
/** 服务端key */
@property (nonatomic, copy) NSString *serviceKey;

/** title */
@property (nonatomic, copy) NSString *title;

/** 输入的值类型 value */
@property (nonatomic, copy) NSString *value, *value2;
/** 输入的值类型 valueId */
@property (nonatomic, copy) NSString *valueId, *value2Id;
/** value值类型描述，如元、折 */
@property (nonatomic, copy) NSString *valueType;
/** placeholder */
@property (nonatomic, copy) NSString *placeholder;
/** 最大输入限制 默认 NSIntegerMax */
@property (nonatomic) NSInteger inputMax;
/** 图片 */
@property (nonatomic, strong) UIImage *logoImage;
/** default is UIKeyboardTypeDefault */
@property (nonatomic) UIKeyboardType keyboardType;

/** 票卷类型list */
@property (nonatomic, strong) NSArray <XMHItemModel *>*couponList;
/** 保存多选数据集合 */
@property (nonatomic, strong) NSArray *dataArray;
/** 保存多选数据集合 是否是全部数据 默认 NO */
@property (nonatomic, getter=isDataArrayAll) BOOL dataArrayAll;
/** 支付详情 */
@property (nonatomic, strong) XMHCouponPayInfoModel *payModel;

+ (XMHFormModel *)createTitle:(nullable NSString *)title type:(XMHFormType)type serviceKey:(nullable NSString *)serviceKey obj:(nullable id)obj isMust:(BOOL)isMust placeholder:(nullable NSString *)placeholder;

/**
 title 必填项描述
 */
- (NSString *)musTitle;

/**
 获取title attributed
 */
- (NSMutableAttributedString *)getTitleAttributedString;

/**
 检验输入文本是否合法

 @param inputText 输入文本
 @return YES 合法
 */
- (BOOL)checkInputText:(NSString *)inputText;

@end

NS_ASSUME_NONNULL_END
