//
//  XMHCredentiaServiceOrderMdoel.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaServiceOrderMdoel.h"

@implementation XMHCredentiaServiceOrderMdoel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

/**
 根据订单类型 订单状态 返回功能项集合
 */
- (NSArray <XMHCredentiaOrderStateItemModel *> *)itemsTitleFromType {
    /*
     type 服务单类型 0服务单，1销售服务单（体验制单）
     zt 服务单状态  1待结算，2已结算，3已完成
     
     销售制单 = 个性制单 + 固定制单 + 升卡续卡
     快速开单
     回收置换 <=> 已购置换
     
     服务制单
     体验制单 <=> 销售服务单
     角色 - 1管理层，2财务人员，3店经理，4技术店长，5销售店长，6售前店长，7前台，8售后美容师，9售前美容师，10售中美容师，11导购
     */
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSInteger role = [ShareWorkInstance shareInstance].share_join_code.framework_function_main_role;
    NSMutableArray *itemArray = NSMutableArray.new;
    NSInteger order_type = [_zt integerValue];
    if (order_type == 1) {
        
        if (role == 1 || role == 11) { //可进行的操作:账单 服务记录
            if (![self isServiceRecord]) {
                [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"服务记录" tag:XMHOrderFunctionTypeFuWuJiLu]];
            }
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
        }else{
           
            if (![self isServiceRecord]) {
                [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"服务记录" tag:XMHOrderFunctionTypeFuWuJiLu]];
            }
            if (role == 7) { //只有前台可以结算
                [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"结算" tag:XMHOrderFunctionTypeJieSuan]];
            }
            if ((role == 2 ||role == 4 ||role == 5 || role == 6 ||role == 8  ||role == 9 || role == 10 || role == 7) && [model.data.account isEqualToString:self.inper] ) { //并且是开单人
                [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"撤销" tag:XMHOrderFunctionTypeCheXiao]];
            }
            
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
        }
      
    } else if (order_type == 2) {
        // 根据Excel权限列表，处理哪些角色可以显示此按钮
        // 开单人可以补业绩
        if ([model.data.account isEqualToString:self.inper] &&
            (role == 4 || role == 5 || role == 6 || role == 7 || role == 8 || role == 9 || role == 10)) {
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"补齐业绩" tag:XMHOrderFunctionTypeBuQiYeJi]];
        }
        if (![self isServiceRecord]) {
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"服务记录" tag:XMHOrderFunctionTypeFuWuJiLu]];
        }
        [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
        
    }else if (order_type == 3) {
        [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
        if (![self isServiceRecord]) {
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"服务记录" tag:XMHOrderFunctionTypeFuWuJiLu]];
        }
    }
    if (role == 11) { //导购什么按钮都不能看到
        itemArray = nil;
    }

    return itemArray;
}

/**
 获取服务记录状态

 @return yes 已服务过。no 未服务过
 */
- (BOOL)isServiceRecord {
    return [_img isEqualToString:@"1"];
}

/**
 拼接项目名称

 @param model model
 @return 拼接后的字符串
 */
+ (NSString *)proNameStr:(XMHCredentiaServiceOrderMdoel *)model {
    NSMutableString *str = NSMutableString.new;
    [model.pro_list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == model.pro_list.count - 1 && IsEmpty(model.goods_list)) {
            [str appendFormat:@"%@", obj];
        } else {
            [str appendFormat:@"%@、", obj];
        }
    }];
    
    [model.goods_list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == model.goods_list.count - 1) {
            [str appendFormat:@"%@", obj];
        } else {
            [str appendFormat:@"%@、", obj];
        }
    }];
    return str;
}

@end
