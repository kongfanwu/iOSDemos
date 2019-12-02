//
//  SPChangeStoreModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSearchStoreUserModel.h"
@interface SPChangeStoreModel : NSObject
@property (nonatomic ,copy)NSString *code;
@property (nonatomic ,copy)NSString *join_name;
@property (nonatomic ,copy)NSString *initiator;
@property (nonatomic ,copy)NSString *outStore;
@property (nonatomic ,strong)NSMutableArray<SPStoreUserModel *> *user;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *mobile;
@property (nonatomic ,copy)NSString *mdname;
@property (nonatomic ,copy)NSString *jis_name;
@property (nonatomic ,copy)NSString *store_code;
@property (nonatomic ,copy)NSString *ID;
@property (nonatomic, copy)NSString * user_store_id;
@end
