//
//  MzzWaiterModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzAccountList,MzzAccountModel;

@interface MzzAccountList : NSObject

@property (nonatomic, strong) NSArray<MzzAccountModel *> *list;

@end

@interface MzzAccountModel : NSObject

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *name;

@end
