//
//  XMHCouponModel.m
//  xmh
//
//  Created by shendengmeiye on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCouponModel.h"

@implementation XMHCouponModel

@synthesize description = _description;

-(id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}

/**
 优惠券类型转枚举
 */
- (XMHActionCouponType)couponType {
    return (XMHActionCouponType)[_type integerValue];
}

/**
 根据 投放状态 返回功能项集合
 */
- (NSArray <XMHCouponListStateItemModel *> *)itemsTitleFromType
{
    /**
     status: 3：未投放 4:已投放 5:已过期
     */
     NSMutableArray *itemArray = NSMutableArray.new;
    if ([_status integerValue] == 3) {
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"删除" tag:XMHCounponFunctionTypeDelete]];
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"启用" tag:XMHCounponFunctionTypeQiYong]];
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"修改" tag:XMHCounponFunctionTypeXiuGai]];
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"修改库存" tag:XMHCounponFunctionTypeXiuGaiKuCun]];
    }else if ([_status integerValue] == 4){
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"停用" tag:XMHCounponFunctionTypeTingYong]];
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"修改库存" tag:XMHCounponFunctionTypeXiuGaiKuCun]];
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]] ) {
            NSLog(@"没有安装微信");
        }else{
            [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"分享" tag:XMHCounponFunctionTypeShare]];
        }
      
    }else if ([_status integerValue] == 5){
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"删除" tag:XMHCounponFunctionTypeDelete]];
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"修改" tag:XMHCounponFunctionTypeXiuGai]];
        [itemArray addObject:[XMHCouponListStateItemModel createTitle:@"修改库存" tag:XMHCounponFunctionTypeXiuGaiKuCun]];
        
    }
    return itemArray;
}
/**
 根据 优惠券type 返回优惠券类型
 */
- (NSString *)couponName
{
    NSString * name = @"";
    if (_type.integerValue == 3) {
        name = @"现金券";
    }else if (_type.integerValue == 4){
        name = @"折扣券";
    }else if (_type.integerValue == 5){
        name = @"礼品券";
    }else{}
    return name;
}
/**
 根据 优惠券status 返回状态
 */
- (NSString *)couponStatus
{
    NSString * status = @"";
    if (_status.integerValue == 1) {
        status = @"未审核";
    }else if (_status.integerValue == 2){
        status = @"审核不通过";
    }else if (_status.integerValue == 3){
        status = @"未投放";
    }else if (_status.integerValue == 4){
        status = @"已投放";
    }else if (_status.integerValue == 5){
        status = @"已过期";
    }else{}
    return status;
}
/**
 根据 优惠券有效期类型 返回有效期
 */
- (NSString *)couponUseableType
{
    NSString * title = @"";
    if (_usable_type.integerValue == 1) {
        title = [NSString stringWithFormat:@"%@-%@",_start_time,_end_time];
    }else if(_usable_type.integerValue == 2){
        title = [NSString stringWithFormat:@"领券%@天后生效，有效期%@天",_delay,_duration];
    }
    return title;
}

/**
 寻找规则下的类型

 @param type 0 会员等级 1 订单商品 2 使用渠道 5 支付使用
 @param rules 服务返回的
 @return 类型dic
 */
+ (NSDictionary *)getRulesType:(NSInteger)type rules:(NSArray *)rules {
    for (NSDictionary *dic in rules) {
        if (!IsEmpty(dic[@"type"])) {
            if ([dic[@"type"] integerValue] == type) {
                return dic;
            }
        }
    }
    return nil;
}
/**
 根据 优惠券类型 返回面额
 */
- (NSString *)couponDenomination
{
    XMHActionCouponType coupon = [self couponType];
    if (coupon == XMHActionCouponTypeXianJin) {
        if (_fulfill.integerValue == 0) {
            return _price;
        }else{
            return [NSString stringWithFormat:@"%@-%@",_fulfill, _price];
        }
    }else if (coupon == XMHActionCouponTypeZheKou){
        return [NSString stringWithFormat:@"%@折",_discount];
    }else if (coupon == XMHActionCouponTypeLiPin){
        return @"--";
    }
    return @"";
}
@end
