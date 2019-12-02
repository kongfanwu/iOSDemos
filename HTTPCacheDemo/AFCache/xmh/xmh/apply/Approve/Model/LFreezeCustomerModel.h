//
//  LFreezeCustomerModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@class LFreezeModel;
@interface LFreezeCustomerModel : NSObject
@property (nonatomic, strong)NSArray<LFreezeModel *> *list;
@end

@interface LFreezeModel : NSObject
@property (nonatomic, assign)NSInteger u_id;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * store_code;
@property (nonatomic, copy)NSString * mobile;
@property (nonatomic, copy)NSString * fram_id;
@property (nonatomic, copy)NSString * user_store_id;

@end
