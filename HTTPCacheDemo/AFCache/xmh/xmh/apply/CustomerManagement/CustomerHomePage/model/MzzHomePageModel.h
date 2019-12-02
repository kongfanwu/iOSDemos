//
//  MzzHomePageModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/18.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MzzJobSelector,MzzShouhou,MzzShouqian,MzzHtmlData;





@interface MzzJobSelector : NSObject

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, strong) MzzShouhou *shouhou;

@property (nonatomic, strong) NSArray<MzzHtmlData *> *group_list;

@property (nonatomic, strong) MzzShouqian *shouqian;

@property (nonatomic, copy) NSString *start_date;

@end

@interface MzzShouhou : NSObject

@property (nonatomic, assign) NSInteger by;

@property (nonatomic, assign) NSInteger xm;

@property (nonatomic, assign) NSInteger ls;

@property (nonatomic, assign) NSInteger xz;

@property (nonatomic, assign) NSInteger xk;

@property (nonatomic, assign) NSInteger bz;

@property (nonatomic, assign) NSInteger td;

@end

@interface MzzShouqian : NSObject

@property (nonatomic, assign) NSInteger jd;

@property (nonatomic, assign) NSInteger sm;

@property (nonatomic, assign) NSInteger sz;

@property (nonatomic, assign) NSInteger zh;

@property (nonatomic, assign) NSInteger cj;

@property (nonatomic, assign) NSInteger td;

@property (nonatomic, assign) NSInteger jh;

@end

@interface MzzHtmlData : NSObject

@property (nonatomic, assign) NSInteger glgk_bfb;

@property (nonatomic, assign) NSInteger glgk;

@property (nonatomic, assign) NSInteger hdgk;

@property (nonatomic, assign) NSInteger yxgk;

@property (nonatomic, assign) NSInteger fid;

@property (nonatomic, assign) NSInteger yxgk_bfb;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger hdgk_bfb;

@end


