//
//  SLSearchManagerModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSelectBaseModel.h"
@class SLManagerModel;

@interface SLSearchManagerModel : NSObject

@property (nonatomic, strong) NSArray<SLManagerModel *> *list;

@end

@interface SLManagerModel : LSelectBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *store_name;

@end


