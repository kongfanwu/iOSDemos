//
//  XMHCredentiaModel.m
//  xmh
//
//  Created by KFW on 2019/4/3.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaModel.h"

@implementation XMHCredentiaModel

/**
 获取销售凭证 订单状态集合
 列表状态：0=>'全部' 1=>'待付款',10=>'已收款',5=>'未付清','6'=>'已完成'
 */
- (NSArray <XMHCredentiaOrderStateItemModel *>*)saleOrderStateList {
//    if (_saleOrderStateList) return _saleOrderStateList;
    
    NSInteger tag = 0;
    for (XMHCredentiaOrderStateItemModel *model in _saleOrderStateList) {
        if (model.selcet) {
            tag = model.tag;
            break;
        }
    }
    
    NSMutableArray *array = NSMutableArray.new;
    _saleOrderStateList = array;
    XMHCredentiaOrderStateItemModel *model;
    NSArray *saleBageArr = _badgeArr;
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"全部";
    model.tag = 0;
//    model.selcet = YES;
    model.badge = [saleBageArr safeObjectAtIndex:0];
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"待付款";
    model.tag = 1;
    model.badge = [saleBageArr safeObjectAtIndex:1];
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"已收款";
    model.tag = 10;
    model.badge = [saleBageArr safeObjectAtIndex:2];
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"未还清";
    model.tag = 5;
    model.badge = [saleBageArr safeObjectAtIndex:3];
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"已完成";
    model.tag = 6;
    model.badge = [saleBageArr safeObjectAtIndex:4];
    [array addObject:model];
    
    for (XMHCredentiaOrderStateItemModel *model in _saleOrderStateList) {
        if (model.tag == tag) {
            model.selcet = YES;
            break;
        }
    }
    
    return array;
}

/**
 获取服务凭证 订单状态集合
 列表状态： 0全部，1待结算，2已结算，3已完成
 */
- (NSArray <XMHCredentiaOrderStateItemModel *>*)serviceOrderStateList {
//    if (_serviceOrderStateList) return _serviceOrderStateList;
    
    NSInteger tag = 0;
    for (XMHCredentiaOrderStateItemModel *model in _serviceOrderStateList) {
        if (model.selcet) {
            tag = model.tag;
            break;
        }
    }
    
    NSMutableArray *array = NSMutableArray.new;
    _serviceOrderStateList = array;
    XMHCredentiaOrderStateItemModel *model;
    NSArray *serviceBageArr = _badgeArr;
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"全部";
    model.tag = 0;
    model.badge = [serviceBageArr safeObjectAtIndex:0];
//    model.selcet = YES;
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"待结算";
    model.tag = 1;
    model.badge = [serviceBageArr safeObjectAtIndex:1];
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"已结算";
    model.tag = 2;
    model.badge = [serviceBageArr safeObjectAtIndex:2];
    [array addObject:model];
    
    model = XMHCredentiaOrderStateItemModel.new;
    model.title = @"已完成";
    model.tag = 3;
    model.badge = [serviceBageArr safeObjectAtIndex:3];
    [array addObject:model];
    
    for (XMHCredentiaOrderStateItemModel *model in _serviceOrderStateList) {
        if (model.tag == tag) {
            model.selcet = YES;
            break;
        }
    }
    
    return array;
}

- (NSArray <XMHCredentiaOrderStateItemModel *>*)currentOrderStateList {
    if (self.type == XMHCredentiaItemViewTypeVendition) {
        return [self saleOrderStateList];
    }
    else if (self.type == XMHCredentiaItemViewTypeService) {
        return [self serviceOrderStateList];
    }
    return nil;
}

/**
 当前订单状态model
 */
- (XMHCredentiaOrderStateItemModel *)currentOrderModel {
    if (self.type == XMHCredentiaItemViewTypeVendition) {
        for (XMHCredentiaOrderStateItemModel *model in [self saleOrderStateList]) {
            if (model.selcet) {
                return model;
            }
        }
    }
    else if (self.type == XMHCredentiaItemViewTypeService) {
        for (XMHCredentiaOrderStateItemModel *model in [self serviceOrderStateList]) {
            if (model.selcet) {
                return model;
            }
        }
    }
    return nil;
}

@end
