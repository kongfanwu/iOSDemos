//
//  TJCustomerActiveListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/10.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJCustomerActiveModel;
@interface TJCustomerActiveListModel : NSObject
@property (nonatomic, strong)NSArray <TJCustomerActiveModel *>*list;
@end
@interface TJCustomerActiveModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *store_name;
@property (nonatomic, copy)NSString *xiaofeijine;
@property (nonatomic, copy)NSString *xiaohaojine;
@property (nonatomic, copy)NSString *haokadanjia;
@property (nonatomic, copy)NSString *xiangmushu;
@property (nonatomic, copy)NSString *xiaofeicishu;
@property (nonatomic, copy)NSString *daodiancishu;
@property (nonatomic, copy)NSString *type;
@end
