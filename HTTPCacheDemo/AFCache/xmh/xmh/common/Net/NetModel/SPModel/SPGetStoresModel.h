//
//  SPGetStoresModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPStoresModel;

@interface SPGetStoresModel : NSObject

@property (nonatomic, strong) NSArray<SPStoresModel *> *list;

@end

@interface SPStoresModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *code;

@end


