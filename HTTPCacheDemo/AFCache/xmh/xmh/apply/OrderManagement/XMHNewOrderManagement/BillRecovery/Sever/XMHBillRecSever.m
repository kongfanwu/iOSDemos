//
//  XMHBillRecSever.m
//  xmh
//
//  Created by shendengmeiye on 2019/3/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHBillRecSever.h"
#import "XMHBillRecoveryOrderRequest.h"
#import "XMHBillReListModel.h"
@interface XMHBillRecSever ()
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *type;

@end

@implementation XMHBillRecSever

- (instancetype)initUserId:(NSString *)userId type:(NSString *)type
{
    if (self = [super init]) {
        self.userId = userId;
        self.type = type;
        [self requestListData];
    }
    return self;
}
- (void)requestListData
{
    if ([self.type isEqualToString:@"pro"]) {//项目
        [self requestProListData];
    }else if ([self.type isEqualToString:@"goods"]){//产品
        [self requestGoodsListData];
    }
    else if ([self.type isEqualToString:@"stored_card"]){//储值卡
         [self requestCardListData];
    }
    else if ([self.type isEqualToString:@"card_num"]){//任选卡
        [self requestOptionalCardListData];
    }
    else if ([self.type isEqualToString:@"card_time"]){//时间卡
        [self requestTimeCardListData];
    }
    else if ([self.type isEqualToString:@"ticket"]){//票券
         [self requestTicketListData];
    }
}
/**
 请求数据
 */
- (void)requestProListData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userId forKey:@"user_id"];
    [param setValue:self.type?self.type:@"" forKey:@"type"];
    [XMHBillRecoveryOrderRequest requestBillRecoveryProContentParams:param
                                                         resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        if (isSuccess) {
            if (_listsBlock) {
                _listsBlock(resultArr,isSuccess);
            }
        }
    }];
}

/**
 产品
 */
- (void)requestGoodsListData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userId forKey:@"user_id"];
    [param setValue:self.type?self.type:@"" forKey:@"type"];
    [XMHBillRecoveryOrderRequest requestBillRecoveryGoodsContentParams:param
                                                           resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                                                               if(isSuccess){
                                                                   if (_listsBlock) {
                                                                       _listsBlock(resultArr,isSuccess);
                                                                   }
                                                               }
    }];
}

/**
 储值卡
 */
- (void)requestCardListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userId forKey:@"user_id"];
    [param setValue:self.type?self.type:@"" forKey:@"type"];
    [XMHBillRecoveryOrderRequest requestBillRecoveryCardContentParams:param
                                                          resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                                                              
                                                              if (isSuccess) {
                                                                  if (_listsBlock) {
                                                                      _listsBlock(resultArr,isSuccess);
                                                                  }

                                                              }
    }];
}

/**
 任选卡
 */
- (void)requestOptionalCardListData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userId forKey:@"user_id"];
    [param setValue:self.type?self.type:@"" forKey:@"type"];
    [XMHBillRecoveryOrderRequest requestBillRecoveryOptionalCardContentParams:param
                                                                  resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                                                                      if (isSuccess) {
                                                                        if (_listsBlock) {
                                                                              _listsBlock(resultArr,isSuccess);
                                                                          }
                                                                      }
    }];
}

/**
 时间卡
 */
- (void)requestTimeCardListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userId forKey:@"user_id"];
    [param setValue:self.type?self.type:@"" forKey:@"type"];
    [XMHBillRecoveryOrderRequest requestBillRecoveryTimeContentParams:param
                                                          resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                                                              if (isSuccess) {
                                                                  if (_listsBlock) {
                                                                      _listsBlock(resultArr,isSuccess);
                                                                  }
                                                              }
        
    }];
}

/**
 o票券
 */
- (void)requestTicketListData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.userId forKey:@"user_id"];
    [param setValue:self.type?self.type:@"" forKey:@"type"];
    [XMHBillRecoveryOrderRequest requestBillRecoveryTicketContentParams:param
                                                            resultBlock:^(NSMutableArray * _Nonnull resultArr, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
                                                                if (isSuccess) {
                                                                    if (_listsBlock) {
                                                                        _listsBlock(resultArr,isSuccess);
                                                                    }
                                                                }
    }];
}


@end
