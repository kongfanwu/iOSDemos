//
//  XMHTicketModel.m
//  xmh
//
//  Created by KFW on 2019/3/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHTicketModel.h"
#import "XMHShoppingCartManager.h"

@implementation XMHTicketModel

- (NSString *)custonId {
    return [NSString stringWithFormat:@"%@%@", _ID, _code];
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

/**
 是否可用， YES 可用
 */
- (BOOL)use {
    return [self.is_use isEqualToString:@"1"];
}

/**
 获取可使用服务卷

 @param modelArray 服务卷集合
 @return 可使用服务卷
 */
+ (NSArray *)useModelArray:(NSArray <XMHTicketModel*> *)modelArray {
    NSMutableArray *useModelArray = NSMutableArray.new;
    
    for (XMHTicketModel *ticketModel in modelArray) {
        BOOL exist = [self shoppingExistTicketModel:ticketModel];
        if ([ticketModel.is_use isEqualToString:@"1"] && exist == NO) {
            [useModelArray addObject:ticketModel];
        }
    }
    return useModelArray;
}

/**
 购物车中是否使用这个优惠券

 @param ticketModel 优惠券
 @return YES 购物车中使用这个优惠券 NO 未使用
 */
+ (BOOL)shoppingExistTicketModel:(XMHTicketModel *)ticketModel {
    for (XMHTicketModel *shoppingTicketModel in XMHShoppingCartManager.sharedInstance.ticketArray) {
        if ([shoppingTicketModel.custonId isEqualToString:ticketModel.custonId]) {
            return YES;
        }
    }
    return NO;
}

/**
 获取不可使用服务卷
 
 @param modelArray 服务卷集合
 @return 可使用服务卷
 */
+ (NSArray *)noModelArray:(NSArray <XMHTicketModel*> *)modelArray {
    NSMutableArray *useModelArray = NSMutableArray.new;
    for (XMHTicketModel *ticketModel in modelArray) {
        if ([ticketModel.is_use isEqualToString:@"2"]) {
            [useModelArray addObject:ticketModel];
        }
    }
    
    // 将购物车中已经使用的优惠券放入到不可使用的列表里
    [useModelArray addObjectsFromArray:XMHShoppingCartManager.sharedInstance.ticketArray];
    
    return useModelArray;
}
@end
