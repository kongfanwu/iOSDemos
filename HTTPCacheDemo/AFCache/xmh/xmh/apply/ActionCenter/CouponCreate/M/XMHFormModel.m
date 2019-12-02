//
//  XMHFormModel.m
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormModel.h"
#import "XMHFormDefaultCell.h"
#import "XMHFormDataCreate.h"
#import "XMHCouponModel.h"
#import "XMHCouponStoreModel.h"

@implementation XMHFormModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isEdit = YES;
        _inputMax = NSIntegerMax;
    }
    return self;
}

+ (XMHFormModel *)createTitle:(NSString *)title type:(XMHFormType)type serviceKey:(NSString *)serviceKey obj:(XMHCouponModel *)obj isMust:(BOOL)isMust placeholder:(NSString *)placeholder {
    XMHFormModel *model = XMHFormModel.new;
    model.type = type;
    model.serviceKey = serviceKey;
    model.title = title;
    model.isMust = isMust;
    model.placeholder = placeholder;
    
    if (!IsEmpty(model.serviceKey)) {
        model.value = [obj valueForKey:model.serviceKey];
    }
    // logo
    if ([model.serviceKey isEqualToString:@"shop_logo"]) {
        model.value = [obj valueForKey:model.serviceKey];
        if (IsEmpty(model.value)) {
            model.value = [ShareWorkInstance shareInstance].share_join_code.join_logo;
        }
    }
    // 有效期:duration  多少天后生效:delay
    else if ([model.serviceKey isEqualToString:@"delay"]) {
        model.value = [obj valueForKey:model.serviceKey];
        model.value2 = [obj valueForKey:@"duration"];
    }
    // 可使用门店
    else if ([model.serviceKey isEqualToString:@"store_codes"]) {
        
        if (([model.value isKindOfClass:[NSString class]] && [model.value isEqualToString:@"*"])
            || IsEmpty(model.value)) {
            model.value = @"所有门店";
            model.dataArrayAll = YES;
        } else {
            NSString *storeCodes = [obj valueForKey:model.serviceKey];
            NSArray *storeList = [storeCodes componentsSeparatedByString:@","];
            
            NSMutableArray *storeDataArray = NSMutableArray.new;
            for (NSString *code in storeList) {
                XMHCouponStoreModel *couponStoreModel = XMHCouponStoreModel.new;
                couponStoreModel.code = code;
                [storeDataArray addObject:couponStoreModel];
            }
            
            model.value = [NSString stringWithFormat:@"已选择%ld家门店", storeList.count];
            model.dataArray = storeDataArray;
        }
    }
    // 使用限制
    else if ([model.serviceKey isEqualToString:@"limit_type"]) {
        NSInteger limit_type = [[obj valueForKey:model.serviceKey] integerValue];
        NSArray *limitTypeList = [XMHFormDataCreate limitTypeList];
        for (XMHItemModel *itemModel in limitTypeList) {
            if (itemModel.ID == limit_type) {
                model.value = itemModel.title;
                model.valueId = @(itemModel.ID).stringValue;
            }
        }
        
        // 设置默认的
        if (IsEmpty(model.value)) {
            XMHItemModel *itemModel  = limitTypeList.firstObject;
            model.value = itemModel.title;
            model.valueId = @(itemModel.ID).stringValue;
        }
    }
    // 发放限制
    else if ([model.serviceKey isEqualToString:@"purview"]) {
        NSInteger purview = [[obj valueForKey:model.serviceKey] integerValue];
        NSArray *sendLimitList = [XMHFormDataCreate sendLimitList];
        for (XMHItemModel *itemModel in sendLimitList) {
            if (itemModel.ID == purview) {
                model.value = itemModel.title;
                model.valueId = @(itemModel.ID).stringValue;
            }
        }
        
        // 设置默认的
        if (IsEmpty(model.value)) {
            XMHItemModel *itemModel  = sendLimitList.firstObject;
            model.value = itemModel.title;
            model.valueId = @(itemModel.ID).stringValue;
        }
    }
    // 会员等级
    else if ([model.serviceKey isEqualToString:@"vipLevel"]) {
        if (([model.value isKindOfClass:[NSString class]] && [model.value isEqualToString:@"*"]) || IsEmpty(model.value)) {
            model.dataArrayAll = YES;
            model.value = @"全部等级";
        } else {
            
        }
        model.dataArray = obj.vipDataArray;
    }
    // 订单商品
    else if ([model.serviceKey isEqualToString:@"orderGoods"]) {
        if (([model.value isKindOfClass:[NSString class]] && [model.value isEqualToString:@"*"]) || IsEmpty(model.value)) {
            model.dataArrayAll = YES;
            model.value = @"全部商品";
        }
        model.dataArray = obj.orderDataArray;
    }
    // 使用渠道
    else if ([model.serviceKey isEqualToString:@"platform"]) {
        if (([model.value isKindOfClass:[NSString class]] && [model.value isEqualToString:@"*"]) || IsEmpty(model.value)) {
            model.dataArrayAll = YES;
            model.value = @"全部渠道";
        }
        model.dataArray = obj.platformDataArray;
    }
    // 支付
    else if ([model.serviceKey isEqualToString:@"pay"]) {
        if (obj.payModel) {
            model.payModel = obj.payModel;
        } else {
            model.payModel = XMHCouponPayInfoModel.new;
        }
        model.value = [model.payModel valueDes];
    }
    // 卡劵副标题
    else if ([model.serviceKey isEqualToString:@"sub_title"]) {
        if (IsEmpty(model.value)) {
            model.value = @"超值优惠券，等您来领";
        }
    }
    // 分享标题
    else if ([model.serviceKey isEqualToString:@"share_title"]) {
        if (IsEmpty(model.value)) {
            model.value = @"快来点击领取属于您的优惠券吧！";
        }
    }
    
    return model;
}

/**
 title 必填项描述
 */
- (NSString *)musTitle {
    if (_isMust) {
        return [NSString stringWithFormat:@"%@ %@", _title, @"*"];
    }
    return _title;
}

/**
 获取title attributed
 */
- (NSMutableAttributedString *)getTitleAttributedString {
    NSString *title = [self musTitle];
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
    if (self.isMust) {
        NSRange range = [title rangeOfString:@"*"];
        [titleAtt addAttribute:NSForegroundColorAttributeName value:kColorTheme range:range];
    }
    return titleAtt;
}

/**
 检验输入文本是否合法
 
 @param inputText 输入文本
 @return YES 合法
 */
- (BOOL)checkInputText:(NSString *)inputText {
    if (IsEmpty(inputText)) return NO;
    
    if (inputText.length <= _inputMax) {
        return YES;
    }
    return NO;
}




@end
