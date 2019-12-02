//
//  MzzConsumptionListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzConsumptionModel;

@interface MzzConsumptionListModel : NSObject

@property (nonatomic, strong) NSArray<MzzConsumptionModel *> *list;

@end

@interface MzzConsumptionModel : NSObject

@property (nonatomic, copy) NSString *z_price;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, strong) NSArray<NSString *> *pro_list;

@property (nonatomic, assign) NSInteger daodian;

@end


