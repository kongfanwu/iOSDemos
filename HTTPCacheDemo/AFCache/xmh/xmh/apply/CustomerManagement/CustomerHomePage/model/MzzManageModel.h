//
//  MzzManageModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ManageData,ShouhouModel,ShouqianModel;

@interface ManageData : NSObject

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, strong) ShouhouModel *shouhou;

@property (nonatomic, strong) ShouqianModel *shouqian;

@property (nonatomic, copy) NSString *start_date;

@end

@interface ShouhouModel : NSObject

@property (nonatomic, assign) NSInteger by;

@property (nonatomic, assign) NSInteger xm;

@property (nonatomic, assign) NSInteger ls;

@property (nonatomic, assign) NSInteger xz;

@property (nonatomic, assign) NSInteger xk;

@property (nonatomic, assign) NSInteger bz;

@property (nonatomic, assign) NSInteger td;

@end

@interface ShouqianModel : NSObject

@property (nonatomic, assign) NSInteger jd;

@property (nonatomic, assign) NSInteger sm;

@property (nonatomic, assign) NSInteger sz;

@property (nonatomic, assign) NSInteger zh;

@property (nonatomic, assign) NSInteger cj;

@property (nonatomic, assign) NSInteger td;

@property (nonatomic, assign) NSInteger jh;

@end


