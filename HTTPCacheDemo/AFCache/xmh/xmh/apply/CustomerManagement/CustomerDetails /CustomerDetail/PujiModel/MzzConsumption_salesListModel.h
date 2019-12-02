//
//  MzzConsumption_salesListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzConsumption_salesModel;

@interface MzzConsumption_salesListModel : NSObject

@property (nonatomic, strong) NSArray<MzzConsumption_salesModel *> *list;

@end

@interface MzzConsumption_salesModel : NSObject

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, copy) NSString *buying_time;

@property (nonatomic, assign) NSInteger jg;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger leiji;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *jump_type;

@end


