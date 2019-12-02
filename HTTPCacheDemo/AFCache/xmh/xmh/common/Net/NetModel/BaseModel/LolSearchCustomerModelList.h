//
//  LolSearchCustomerModelList.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@class LolSearchCustomerModel;
@interface LolSearchCustomerModelList : NSObject
@property (strong ,nonatomic)NSMutableArray<LolSearchCustomerModel *> * list;
@end
