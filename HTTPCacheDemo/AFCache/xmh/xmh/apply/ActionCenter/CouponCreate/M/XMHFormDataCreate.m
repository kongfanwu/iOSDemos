//
//  XMHFormDataCreate.m
//  xmh
//
//  Created by KFW on 2019/5/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormDataCreate.h"
#import "XMHCouponStoreModel.h"
#import "XMHServiceGoodsModel.h"
#import "NSString+Check.h"

@implementation XMHFormDataCreate
/**
 创建现金劵
 */
- (NSMutableArray *)createFormListCouponModel:(XMHCouponModel *)couponModel edit:(BOOL)edit createType:(XMHActionCreateType)createType {
    NSMutableArray *_dataArray = NSMutableArray.new;
    self.formListArray = _dataArray;
    
    XMHFormSectionModel *sectionModel;
    XMHFormModel *model;
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"基本信息";
    [_dataArray addObject:sectionModel];
    
    if (createType == XMHActionCreateTypeCreate) {
        model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeCoupon serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
        model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
        [sectionModel.sectionArray addObject:model];
        for (XMHItemModel *itemMdoel in model.couponList) {
            if (itemMdoel.type == XMHActionCouponTypeXianJin) {
                model.valueId = @(itemMdoel.type).stringValue;
                itemMdoel.isSelect = YES;
            }
        }
        // 修改状态不可编辑
        model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
    } else {
        model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeInputTextField serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
        model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
        [sectionModel.sectionArray addObject:model];
        // 修改状态不可编辑
        model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
        for (XMHItemModel *itemMdoel in model.couponList) {
            NSString *value = [couponModel valueForKey:model.serviceKey];
            if ([@(itemMdoel.type).stringValue isEqualToString:value]) {
                model.value = itemMdoel.title;
                model.valueId = @(itemMdoel.type).stringValue;
                break;
            }
        }
    }
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"券面设置";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"品牌简称" type:XMHFormTypeInputTextField serviceKey:@"brand" obj:couponModel isMust:YES placeholder:@"不超过10个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 10;
    
    model = [XMHFormModel createTitle:@"商户LOGO" type:XMHFormTypeImage serviceKey:@"shop_logo" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"卡劵名称" type:XMHFormTypeInputTextField serviceKey:@"name" obj:couponModel isMust:YES placeholder:@"描述卡券提供具体优惠，不超过9个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 9;
    
    model = [XMHFormModel createTitle:@"卡劵副标题" type:XMHFormTypeInputTextView serviceKey:@"sub_title" obj:couponModel isMust:NO placeholder:@"不超过30个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 30;
    
    model = [XMHFormModel createTitle:@"分享标题" type:XMHFormTypeInputTextView serviceKey:@"share_title" obj:couponModel isMust:YES placeholder:@"不超过20个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 20;
    
    model = [XMHFormModel createTitle:@"卡券金额" type:XMHFormTypeInputTextField serviceKey:@"price" obj:couponModel isMust:YES placeholder:@"抵扣金额"];
    model.valueType = @"元";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"最低消费金额" type:XMHFormTypeInputTextField serviceKey:@"fulfill" obj:couponModel isMust:NO placeholder:@"输入0时，默认没有限制门栏"];
    model.valueType = @"元";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    // 有效期:duration  多少天后生效:delay
    model = [XMHFormModel createTitle:@"有效期" type:XMHFormTypeDateStartEnd serviceKey:@"delay" obj:couponModel isMust:YES placeholder:nil];
    model.valueType = @"元";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"领劵设置";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"库存数" type:XMHFormTypeInputTextField serviceKey:@"store_num" obj:couponModel isMust:YES placeholder:@"请输入数量"];
    model.valueType = @"份";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"可使用门店" type:XMHFormTypeSelect serviceKey:@"store_codes" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"使用限制" type:XMHFormTypeSelectNoEditContentFilled serviceKey:@"limit_type" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"发放限制" type:XMHFormTypeSelectNoEditContentFilled serviceKey:@"purview" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"使用条件";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"使用条件：" type:XMHFormTypeContentFilled serviceKey:nil obj:couponModel isMust:NO placeholder:nil];
    model.value = @"设置券的使用条件：使用渠道如不设置，则默认为线下使用，商品绑定如不设置，则默认为需要绑定商品";
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"会员等级" type:XMHFormTypeSelect serviceKey:@"vipLevel" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];

    model = [XMHFormModel createTitle:@"订单商品" type:XMHFormTypeSelect serviceKey:@"orderGoods" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];

    model = [XMHFormModel createTitle:@"使用渠道" type:XMHFormTypeSelect serviceKey:@"platform" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];

    model = [XMHFormModel createTitle:@"支付使用" type:edit ? XMHFormTypeSelect : XMHFormTypeSelectNoEditContentFilled serviceKey:@"pay" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    for (XMHFormSectionModel *sectionModel in _dataArray) {
        for (XMHFormModel *formModel in sectionModel.sectionArray) {
            if ([formModel.serviceKey isEqualToString:@"type"]) continue;
            formModel.isEdit = edit;
        }
    }
    
    return _dataArray;
}

/**
 创建折扣劵
 */
- (NSMutableArray *)createFormZheKouListCouponModel:(XMHCouponModel *)couponModel edit:(BOOL)edit createType:(XMHActionCreateType)createType {
    NSMutableArray *_dataArray = NSMutableArray.new;
    self.formListArray = _dataArray;
    
    XMHFormSectionModel *sectionModel;
    XMHFormModel *model;
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"基本信息";
    [_dataArray addObject:sectionModel];
    
//    model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeCoupon serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
//    model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
//    [sectionModel.sectionArray addObject:model];
//    // 修改状态不可编辑
//    model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
//    for (XMHItemModel *itemMdoel in model.couponList) {
//        if (itemMdoel.type == XMHActionCouponTypeZheKou) {
//            model.value = @(itemMdoel.type).stringValue;
//            itemMdoel.isSelect = YES;
//        }
//    }
    
    if (createType == XMHActionCreateTypeCreate) {
        model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeCoupon serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
        model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
        [sectionModel.sectionArray addObject:model];
        for (XMHItemModel *itemMdoel in model.couponList) {
            if (itemMdoel.type == XMHActionCouponTypeZheKou) {
                model.valueId = @(itemMdoel.type).stringValue;
                itemMdoel.isSelect = YES;
            }
        }
        // 修改状态不可编辑
        model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
    } else {
        model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeInputTextField serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
        model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
        [sectionModel.sectionArray addObject:model];
        // 修改状态不可编辑
        model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
        for (XMHItemModel *itemMdoel in model.couponList) {
            NSString *value = [couponModel valueForKey:model.serviceKey];
            if ([@(itemMdoel.type).stringValue isEqualToString:value]) {
                model.value = itemMdoel.title;
                model.valueId = @(itemMdoel.type).stringValue;
                break;
            }
        }
    }
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"券面设置";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"品牌简称" type:XMHFormTypeInputTextField serviceKey:@"brand" obj:couponModel isMust:YES placeholder:@"不超过10个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 10;
    
    model = [XMHFormModel createTitle:@"商户LOGO" type:XMHFormTypeImage serviceKey:@"shop_logo" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"卡劵名称" type:XMHFormTypeInputTextField serviceKey:@"name" obj:couponModel isMust:YES placeholder:@"描述卡券提供具体优惠，不超过9个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 9;
    
    model = [XMHFormModel createTitle:@"卡劵副标题" type:XMHFormTypeInputTextView serviceKey:@"sub_title" obj:couponModel isMust:NO placeholder:@"不超过30个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 30;
    
    model = [XMHFormModel createTitle:@"分享标题" type:XMHFormTypeInputTextView serviceKey:@"share_title" obj:couponModel isMust:YES placeholder:@"不超过20个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 20;
    
    model = [XMHFormModel createTitle:@"折扣额度" type:XMHFormTypeDiscount serviceKey:@"discount" obj:couponModel isMust:YES placeholder:@"请输入折扣"];
    model.value2 = @"1-9.9之间的数字，精确到小数点后1位";
    model.valueType = @"折";
    model.keyboardType = UIKeyboardTypeDecimalPad;
    [sectionModel.sectionArray addObject:model];

    model = [XMHFormModel createTitle:@"折扣限额" type:XMHFormTypeDiscount serviceKey:@"fulfill" obj:couponModel isMust:NO placeholder:@"请输入金额"];
    model.value2 = @"限制最多可抵扣的金额，不填则实际按折扣金额抵扣";
    model.valueType = @"元";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    // 有效期:duration  多少天后生效:delay
    model = [XMHFormModel createTitle:@"有效期" type:XMHFormTypeDateStartEnd serviceKey:@"delay" obj:couponModel isMust:YES placeholder:nil];
    model.valueType = @"元";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"领劵设置";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"库存数" type:XMHFormTypeInputTextField serviceKey:@"store_num" obj:couponModel isMust:YES placeholder:@"请输入数量"];
    model.valueType = @"份";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"可使用门店" type:XMHFormTypeSelect serviceKey:@"store_codes" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"使用限制" type:XMHFormTypeSelectNoEditContentFilled serviceKey:@"limit_type" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"发放限制" type:XMHFormTypeSelectNoEditContentFilled serviceKey:@"purview" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"使用条件";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"使用条件：" type:XMHFormTypeContentFilled serviceKey:nil obj:couponModel isMust:NO placeholder:nil];
    model.value = @"设置券的使用条件：使用渠道如不设置，则默认为线下使用，商品绑定如不设置，则默认为需要绑定商品";
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"会员等级" type:XMHFormTypeSelect serviceKey:@"vipLevel" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"订单商品" type:XMHFormTypeSelect serviceKey:@"orderGoods" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"使用渠道" type:XMHFormTypeSelect serviceKey:@"platform" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"支付使用" type:edit ? XMHFormTypeSelect : XMHFormTypeSelectNoEditContentFilled serviceKey:@"pay" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    for (XMHFormSectionModel *sectionModel in _dataArray) {
        for (XMHFormModel *formModel in sectionModel.sectionArray) {
            if ([formModel.serviceKey isEqualToString:@"type"]) continue;
            formModel.isEdit = edit;
        }
    }
    
    return _dataArray;
}

/**
 创建礼品劵
 */
- (NSMutableArray *)createFormLiPinListCouponModel:(XMHCouponModel *)couponModel edit:(BOOL)edit createType:(XMHActionCreateType)createType {
    NSMutableArray *_dataArray = NSMutableArray.new;
    self.formListArray = _dataArray;
    
    XMHFormSectionModel *sectionModel;
    XMHFormModel *model;
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"基本信息";
    [_dataArray addObject:sectionModel];
    
//    model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeCoupon serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
//    model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
//    [sectionModel.sectionArray addObject:model];
//    // 修改状态不可编辑
//    model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
//    for (XMHItemModel *itemMdoel in model.couponList) {
//        if (itemMdoel.type == XMHActionCouponTypeLiPin) {
//            model.value = @(itemMdoel.type).stringValue;
//            itemMdoel.isSelect = YES;
//        }
//    }
    
    if (createType == XMHActionCreateTypeCreate) {
        model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeCoupon serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
        model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
        [sectionModel.sectionArray addObject:model];
        for (XMHItemModel *itemMdoel in model.couponList) {
            if (itemMdoel.type == XMHActionCouponTypeLiPin) {
                model.valueId = @(itemMdoel.type).stringValue;
                itemMdoel.isSelect = YES;
            }
        }
        // 修改状态不可编辑
        model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
    } else {
        model = [XMHFormModel createTitle:@"优惠券类型" type:XMHFormTypeInputTextField serviceKey:@"type" obj:couponModel isMust:NO placeholder:nil];
        model.couponList = [XMHFormDataCreate couponTypeListBlcok:nil];
        [sectionModel.sectionArray addObject:model];
        // 修改状态不可编辑
        model.isEdit = createType == XMHActionCreateTypeEdit ? NO : edit;
        for (XMHItemModel *itemMdoel in model.couponList) {
            NSString *value = [couponModel valueForKey:model.serviceKey];
            if ([@(itemMdoel.type).stringValue isEqualToString:value]) {
                model.value = itemMdoel.title;
                model.valueId = @(itemMdoel.type).stringValue;
                break;
            }
        }
    }
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"券面设置";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"品牌简称" type:XMHFormTypeInputTextField serviceKey:@"brand" obj:couponModel isMust:YES placeholder:@"不超过10个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 10;
    
    model = [XMHFormModel createTitle:@"商户LOGO" type:XMHFormTypeImage serviceKey:@"shop_logo" obj:couponModel isMust:YES placeholder:@"品牌简称"];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"卡劵名称" type:XMHFormTypeInputTextField serviceKey:@"name" obj:couponModel isMust:YES placeholder:@"描述卡券提供具体优惠，不超过9个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 9;
    
    model = [XMHFormModel createTitle:@"卡劵副标题" type:XMHFormTypeInputTextView serviceKey:@"sub_title" obj:couponModel isMust:NO placeholder:@"不超过30个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 30;
    
    model = [XMHFormModel createTitle:@"分享标题" type:XMHFormTypeInputTextView serviceKey:@"share_title" obj:couponModel isMust:YES placeholder:@"不超过20个字"];
    [sectionModel.sectionArray addObject:model];
    model.inputMax = 20;
    
    // 有效期:duration  多少天后生效:delay
    model = [XMHFormModel createTitle:@"有效期" type:XMHFormTypeDateStartEnd serviceKey:@"delay" obj:couponModel isMust:YES placeholder:nil];
    model.valueType = @"元";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"领劵设置";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"库存数" type:XMHFormTypeInputTextField serviceKey:@"store_num" obj:couponModel isMust:YES placeholder:@"请输入数量"];
    model.valueType = @"份";
    model.keyboardType = UIKeyboardTypeNumberPad;
    model.inputMax = 7;
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"可使用门店" type:XMHFormTypeSelect serviceKey:@"store_codes" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"使用限制" type:XMHFormTypeSelectNoEditContentFilled serviceKey:@"limit_type" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"发放限制" type:XMHFormTypeSelectNoEditContentFilled serviceKey:@"purview" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    
    sectionModel = XMHFormSectionModel.new;
    sectionModel.title = @"使用条件";
    [_dataArray addObject:sectionModel];
    
    model = [XMHFormModel createTitle:@"使用条件：" type:XMHFormTypeContentFilled serviceKey:nil obj:couponModel isMust:NO placeholder:nil];
    model.value = @"设置券的使用条件：使用渠道如不设置，则默认为线下使用，商品绑定如不设置，则默认为需要绑定商品";
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"会员等级" type:XMHFormTypeSelect serviceKey:@"vipLevel" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"订单商品" type:XMHFormTypeSelect serviceKey:@"orderGoods" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    model = [XMHFormModel createTitle:@"使用渠道" type:XMHFormTypeSelect serviceKey:@"platform" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    
    model = [XMHFormModel createTitle:@"支付使用" type:edit ? XMHFormTypeSelect : XMHFormTypeSelectNoEditContentFilled serviceKey:@"pay" obj:couponModel isMust:YES placeholder:nil];
    [sectionModel.sectionArray addObject:model];
    
    for (XMHFormSectionModel *sectionModel in _dataArray) {
        for (XMHFormModel *formModel in sectionModel.sectionArray) {
            if ([formModel.serviceKey isEqualToString:@"type"]) continue;
            formModel.isEdit = edit;
        }
    }
    
    return _dataArray;
}

/**
 根据 serviceKey 寻找 _formListArray XMHFormModel

 @param serviceKey XMHFormModel 属性
 @return XMHFormModel
 */
- (XMHFormModel *)formModelfromServiceKey:(NSString *)serviceKey {
    if (IsEmpty(serviceKey)) return nil;
    for (XMHFormSectionModel *sectionModel in _formListArray) {
        for (XMHFormModel *formMdoel in sectionModel.sectionArray) {
            if ([formMdoel.serviceKey isEqualToString:serviceKey]) {
                return formMdoel;
            }
        }
    }
    return nil;
}

/**
 优惠券类型集合
 */
+ (NSArray <XMHItemModel *>*)couponTypeListBlcok:(void(^)(XMHItemModel *itemModel))block {
    NSArray *array = @[[XMHItemModel createTitle:@"现金劵" type:XMHActionCouponTypeXianJin select:NO],
      [XMHItemModel createTitle:@"折扣劵" type:XMHActionCouponTypeZheKou select:NO],
      [XMHItemModel createTitle:@"礼品劵" type:XMHActionCouponTypeLiPin select:NO]];
    if (block) block(array.firstObject);
    return array;
}

/**
 获取优惠券使用条件集合
 */
+ (NSArray <XMHItemModel *>*)limitTypeList {
    NSMutableArray *array = NSMutableArray.new;
    XMHItemModel *model;
    model = XMHItemModel.new;
    [array addObject:model];
    model.ID = 1;
    model.title = @"可转赠/可自己使用";
    
    model = XMHItemModel.new;
    [array addObject:model];
    model.ID = 2;
    model.title = @"不可转赠/可自己使用";
    
    model = XMHItemModel.new;
    [array addObject:model];
    model.ID = 3;
    model.title = @"可转赠/初始领取人不可使用";
    return array;
}
+ (NSArray <XMHItemModel *>*)sendLimitList {
    NSMutableArray *array = NSMutableArray.new;
    XMHItemModel *model;
    model = XMHItemModel.new;
    [array addObject:model];
    model.ID = 1;
    model.title = @"所有人都可发放";
    
    model = XMHItemModel.new;
    [array addObject:model];
    model.ID = 0;
    model.title = @"仅管理员";
    return array;
}
/**
 使用渠道
 */
+ (NSArray <XMHItemModel *>*)platformList {
    NSMutableArray *array = NSMutableArray.new;
    XMHItemModel *model;
    model = XMHItemModel.new;
    [array addObject:model];
    model.idStr = @"all";
    model.title = @"全选";
    
    model = XMHItemModel.new;
    [array addObject:model];
    model.idStr = @"app";
    model.title = @"APP";
    
    model = XMHItemModel.new;
    [array addObject:model];
    model.idStr = @"pc";
    model.title = @"PC";
    
    model = XMHItemModel.new;
    [array addObject:model];
    model.idStr = @"wechat";
    model.title = @"微信";
    
    model = XMHItemModel.new;
    [array addObject:model];
    model.idStr = @"offline";
    model.title = @"线下";
    return array;
}

/**
 拼接 可使用门店服务端 store_code 字段

 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSMutableArray *)getStoreCodeFormModel:(XMHFormModel *)formMdoel {
    NSMutableArray *array = NSMutableArray.new;
    for (int i = 0; i < formMdoel.dataArray.count; i++) {
        XMHCouponStoreModel *model = formMdoel.dataArray[i];
        [array addObject:model.code];
    }
    return array;
}

/**
 拼接 会员等级 数据

 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSString *)getVipLevelFormModel:(XMHFormModel *)formMdoel {
    // 全部数据，返回 *
    if (formMdoel.isDataArrayAll) return @"*";
    
    NSMutableString *str = NSMutableString.new;
    for (int i = 0; i < formMdoel.dataArray.count; i++) {
        XMHItemModel *model = formMdoel.dataArray[i];
        if (i == formMdoel.dataArray.count - 1) {
            [str appendFormat:@"%@", model.idStr];
        } else {
            [str appendFormat:@"%@,", model.idStr];
        }
    }
    return str;
}

/**
 拼接 订单商品 数据
 
 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSString *)getOrderGoodsFormModel:(XMHFormModel *)formMdoel {
    // 全部数据，返回 *
    if (formMdoel.isDataArrayAll) return @"*";
    
    NSMutableArray *array = NSMutableArray.new;
    for (int i = 0; i < formMdoel.dataArray.count; i++) {
        XMHServiceGoodsModel *goodsModel = formMdoel.dataArray[i];
        NSRange range = [goodsModel.code rangeOfString:@"PR"];

        NSMutableDictionary *param = NSMutableDictionary.new;
        [array addObject:param];
        param[@"id"] = goodsModel.ID;
        param[@"code"] = goodsModel.code;
        param[@"name"] = goodsModel.name;
        // 存在PR,说明是项目，
        if (range.length == 2 && range.location != NSNotFound) {
            param[@"types"] = @"项目";
        } else {
            param[@"types"] = @"产品";
        }
//        param[@"price"] = goodsModel.ID;
//        param[@"stock"] = goodsModel.ID;
    }
    return [array yy_modelToJSONString];
}

/**
 拼接 使用渠道 数据
 
 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSString *)getPlatformFormModel:(XMHFormModel *)formMdoel {
    // 全部数据，返回 *
    if (formMdoel.isDataArrayAll) return @"*";
    
    NSMutableString *str = NSMutableString.new;
    for (int i = 0; i < formMdoel.dataArray.count; i++) {
        XMHItemModel *model = formMdoel.dataArray[i];
        if (i == formMdoel.dataArray.count - 1) {
            [str appendFormat:@"%@", model.idStr];
        } else {
            [str appendFormat:@"%@,", model.idStr];
        }
    }
    return str;
}

/**
 拼接 支付 数据
 
 @param formMdoel 表单中选择的门店model
 @return 拼接后的字符串
 */
+ (NSString *)getPayFormModel:(XMHFormModel *)formMdoel {
    NSMutableString *str = NSMutableString.new;
    for (int i = 0; i < formMdoel.dataArray.count; i++) {
        XMHItemModel *model = formMdoel.dataArray[i];
        if (i == formMdoel.dataArray.count - 1) {
            [str appendFormat:@"%@", model.idStr];
        } else {
            [str appendFormat:@"%@,", model.idStr];
        }
    }
    return str;
}

/**
 校验必填项
 return YES 通过 NO 未通过
 */
+ (BOOL)checkMustParamFormModel:(XMHFormModel *)formModel block:(void(^)(NSString *des))block {
    // 非强制填写
    if (!formModel.isMust || IsEmpty(formModel.serviceKey)) {
        if (block) block(nil);
        return YES;
    }
    // 有效期
    if ([formModel.serviceKey isEqualToString:@"delay"]) {
        if (IsEmpty(formModel.value) || IsEmpty(formModel.value2)) {
            if (block) block([NSString stringWithFormat:@"%@未填写", formModel.title]);
            return NO;
        }
    }
    // 折扣额度
    else if ([formModel.serviceKey isEqualToString:@"discount"]) {
        BOOL bl = [formModel.value evaluateRegex:XMHRegexOneNumOneFloat];
        if (!bl) {
            if (block) block([NSString stringWithFormat:@"%@填写错误", formModel.title]);
            return NO;
        }
    }
    // 可使用门店
   else  if ([formModel.serviceKey isEqualToString:@"store_codes"]) {
       if (IsEmpty(formModel.dataArray) && formModel.dataArrayAll == NO) {
           if (block) block([NSString stringWithFormat:@"%@未填写", formModel.title]);
           return NO;
       }
   }
    // 订单商品
    else if ([formModel.serviceKey isEqualToString:@"orderGoods"]) {
        if (IsEmpty(formModel.dataArray) && formModel.dataArrayAll == NO) {
            if (block) block([NSString stringWithFormat:@"%@未填写", formModel.title]);
            return NO;
        }
    }
    // 通用情况
    else {
        if (IsEmpty(formModel.value)) {
            if (block) block([NSString stringWithFormat:@"%@未填写", formModel.title]);
            return NO;
        }
    }
    
    if (block) block(nil);
    return YES;
}

@end
