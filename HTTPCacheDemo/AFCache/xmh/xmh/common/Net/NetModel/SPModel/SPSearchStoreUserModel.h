//
//  SPSearchStoreUserModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPStoreUserModel;

@interface SPSearchStoreUserModel : NSObject

@property (nonatomic, strong) NSMutableArray<SPStoreUserModel *> *list;

@end

@interface SPStoreUserModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy)NSString * user_store_id;

@end


