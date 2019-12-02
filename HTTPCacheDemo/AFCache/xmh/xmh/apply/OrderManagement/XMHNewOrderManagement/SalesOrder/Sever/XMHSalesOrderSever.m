//
//  XMHSalesOrderSever.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHSalesOrderSever.h"
#import "XMHSaleOrderRequest.h"
#import "MzzStoreModel.h"
#import "MzzCustomerRequest.h"

@interface XMHSalesOrderSever()
@property (nonatomic, copy)NSString *store_code;//商家编码
@property (nonatomic, copy)NSString *userId;//用户id
@property (nonatomic, copy)NSString *type;
@end

@implementation XMHSalesOrderSever

- (instancetype)initUserId:(NSString *)userId type:(NSString *)type storeCode:(NSString *)storeCode;
{
    if (self = [super init]) {
        self.type = type;
        self.userId = userId;
        self.store_code = storeCode;
//        if (!self.store_code) {
//            [self getCustomerStoreCode];
//        }else{
             [self requestData];
//        }
    }
    return self;
}
/**
 获取门店编码
 */
-(void)getCustomerStoreCode
{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    //门店归属
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            MzzStoreList *storeList = listModel;
            MzzStoreModel *selectStoreModel = storeList.list[0];
            self.store_code = selectStoreModel.store_code;
            [self requestData];
        }
    }];
}

-(void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[ShareWorkInstance shareInstance].share_join_code.store_code?[ShareWorkInstance shareInstance].share_join_code.store_code : @"" forKey:@"store_code"];
    [params setObject:self.userId forKey:@"user_id"];
    [params setObject:self.type forKey:@"type"];
    [XMHSaleOrderRequest requestSaleOrderContentParams:params resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        NSMutableArray *result = [NSMutableArray array];
        if (isSuccess) {
            result = resultArr;
        }else{
            result = nil;
        }
        if (_saleOrderSeverDataArr) {
            _saleOrderSeverDataArr(result);
        }
    }];
}

-(CGFloat)cellHeight
{
    CGFloat cellH = 0;
    if ([self.type isEqualToString:@"pro"] ||
        [self.type isEqualToString:@"goods"] ||
        [self.type isEqualToString:@"card_course"] ||
        [self.type isEqualToString:@"card_time"] ||
        [self.type isEqualToString:@"ticket"] ||
        [self.type isEqualToString:@"skxk"]) {
        cellH = 65;
    }
    else if ([self.type isEqualToString:@"card_num"] ){
        cellH = 80;
    }else if ([self.type isEqualToString:@"stored_card"]){
        cellH = 110;
    }
    _cellHeight = cellH;
    return _cellHeight;
}


@end
