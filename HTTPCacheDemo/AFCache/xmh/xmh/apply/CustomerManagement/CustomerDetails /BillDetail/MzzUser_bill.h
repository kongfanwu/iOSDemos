//
//  MzzUser_bill.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/18.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzBillCardModel;

@interface MzzUser_bill : NSObject

@property (nonatomic, strong) NSArray<MzzBillCardModel *> *list;

@end

@interface MzzBillCardModel : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger is_have;

@property (nonatomic, copy) NSString *name;

@end


