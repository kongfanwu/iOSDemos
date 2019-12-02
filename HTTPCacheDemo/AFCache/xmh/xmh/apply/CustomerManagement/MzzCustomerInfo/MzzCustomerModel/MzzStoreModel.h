//
//  MzzStoreModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSelectBaseModel.h"
@class MzzStoreList,MzzStoreModel;

@interface MzzStoreList : NSObject

@property (nonatomic, strong) NSArray<MzzStoreModel *> *list;

@end

@interface MzzStoreModel : LSelectBaseModel

@property (nonatomic, strong) NSString *store_code;

@property (nonatomic, strong) NSString *store_name;

@end
