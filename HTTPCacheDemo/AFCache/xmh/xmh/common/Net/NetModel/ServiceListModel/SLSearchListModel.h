//
//  SLSearchListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLSearchModel;

@interface SLSearchListModel : NSObject

@property (nonatomic, strong) NSArray<SLSearchModel *> *list;

@end

@interface SLSearchModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fram_id;

@end


