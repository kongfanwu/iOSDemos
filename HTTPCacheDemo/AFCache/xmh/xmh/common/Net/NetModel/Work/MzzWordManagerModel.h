//
//  MzzWordManagerModel.h
//  xmh
//
//  Created by Ss H on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MzzManageModel;

@interface MzzWordManagerModel : NSObject
@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSMutableArray<MzzManageModel *> *list;

@property (nonatomic, assign) NSInteger code;

@end
@interface MzzManageModel : NSObject

@property (nonatomic, copy) NSString *name;//门店名称

@property (nonatomic, copy) NSString *ach;//业绩

@property (nonatomic, assign) NSInteger exp;//消耗

@property (nonatomic, copy) NSString *appo;//预约

@property (nonatomic, copy) NSString *drai;//引流

@property (nonatomic, assign) NSInteger num;//客次

@property (nonatomic, copy) NSString *pro;//项目

@property (nonatomic, copy) NSString *vali;//有效客

@property (nonatomic, copy) NSString *pro_p;//客均项目

@property (nonatomic, copy) NSString *exp_p;//客均消耗

@property (nonatomic, copy) NSString *admit;//人均接待

@property (nonatomic, copy) NSString *handl;//人均操作


@end
