//
//  XMHCredentiaSalesOrderMdoel.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaSalesOrderMdoel.h"

@implementation XMHCredentiaSalesOrderMdoel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

/**
 根据订单类型 订单状态 返回功能项集合
 */
- (NSArray <XMHCredentiaOrderStateItemModel *> *)itemsTitleFromType {
    /*
      type 制单类型： "1" => "固定制单", "2" => "已购置换", "3" => "个性制单", "4" => "升卡续卡", "5" => "快速开单"
      order_type 订单状态 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成' 10=>'已收款未补齐项目',11=>'已收款未补齐业绩',
    
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
    NSInteger order_type = [_order_type integerValue];
    NSInteger type = [_type integerValue];
    if (order_type == 1) {
        
        if ((role == 2 ||role == 4 ||role == 5 || role == 6 ||role == 8  ||role == 9 || role == 10 || role == 7) && [model.data.account isEqualToString:self.inper] ) { //并且是开单人
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"撤销" tag:XMHOrderFunctionTypeCheXiao]];
        }
        // 19.5.27 只有前台可以结算 && 非分享订单
        if (role == 7 && !_share){
             [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"结算" tag:XMHOrderFunctionTypePay]];
        }
        
        // 19.5.27 显示分享按钮条件：开单人 && 销售制单 && 代付款状态 && 分享单子 
        if ([model.data.account isEqualToString:self.inper] && _share) {
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"分享" tag:XMHOrderFunctionTypeShare]];
        }
        
        [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
        
    } else if (order_type == 10 || order_type == 11) {
        // 快速开单
        if (type == 5) {
            if (order_type == 10 ) {
                if (role == 7 ) { //只有role = 7能看到补齐项目
                    [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"补齐项目" tag:XMHOrderFunctionTypeBuQiXiangMu]];
                }
            }
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
           
        }
        // 销售制单
        else {
            // 并且是开单人可以补业绩
            if ((role == 2 ||role == 4 ||role == 5 || role == 6 ||role == 8 ||role == 9 || role == 10|| role == 7) && [model.data.account isEqualToString:self.inper]) {
                  [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"补齐业绩" tag:XMHOrderFunctionTypeBuQiYeJi]];
            }
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
          
        }
    } else if (order_type == 5) {
        if (role == 7) { //前台可以看到还款按钮
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"还款" tag:XMHOrderFunctionTypeHuanKuan]];
            [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"终止" tag:XMHOrderFunctionTypeZhongZhi]];
        }
        [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
       
    } else if (order_type == 6) {
        [itemArray addObject:[XMHCredentiaOrderStateItemModel createTitle:@"账单" tag:XMHOrderFunctionTypeLookZhangDan]];
    }
    
   
    if (role == 11) { //导购什么按钮都不能看到
        itemArray = nil;
    }
    return itemArray;
}

/**
 新的type类型描述
 */
- (NSString *)newTypeName {
    NSInteger order_type = [_order_type integerValue];
    NSInteger type = [_type integerValue];
    if (order_type == 10 && type != 5) {
        return @"销售服务单";
    }
    
    return _type_name;
}

@end
