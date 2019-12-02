//
//  TJCustomerListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/5.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJCustomerModel;
@interface TJCustomerListModel : NSObject
@property (nonatomic, strong)NSArray <TJCustomerModel *>*list;
@end

@interface TJCustomerModel : NSObject
/** 销售业绩 */
@property (nonatomic, copy)NSString *xiaoshouyeji;
/** 消耗业绩 */
@property (nonatomic, copy)NSString *xiaohaoyeji;
/** 接待客次 */
@property (nonatomic, copy)NSString *keci;
/** 成交人数 */
@property (nonatomic, copy)NSString *chengjiao;
/** 消耗项目数 */
@property (nonatomic, copy)NSString *shicaoxiangmushu;
@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *store_name;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *bfb1;
@property (nonatomic, copy)NSString *bfb2;
@property (nonatomic, copy)NSString *bfb3;
@property (nonatomic, copy)NSString *bfb4;
@property (nonatomic, copy)NSString *bfb5;

@property (nonatomic, copy)NSString *rank1;
@property (nonatomic, copy)NSString *rank2;
@property (nonatomic, copy)NSString *rank3;
@property (nonatomic, copy)NSString *rank4;
@property (nonatomic, copy)NSString *rank5;
@property (nonatomic, strong)NSDictionary * totalDict;
@end
