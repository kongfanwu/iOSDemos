//
//  MzzCardsModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MzzFilterBaseModel.h"
@class MzzCardsModel;
@interface ESRootClass : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray<MzzCardsModel *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface MzzCardsModel : MzzFilterBaseModel

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *type;

@end


