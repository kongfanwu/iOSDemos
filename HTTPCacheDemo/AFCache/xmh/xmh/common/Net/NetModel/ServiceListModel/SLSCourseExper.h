//
//  SLSCourseExper.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SATicketListModel.h"
#import "XMHTicketModel.h"
#import "XMHExperienceOrderBaseModel.h"

@class SLCourseExperList,SLGoods_ListM,SLPro_ListM, MLJiShiModel;

@interface SLSCourseExper : NSObject
@property (nonatomic,assign)BOOL isShow;
@property (nonatomic, strong) NSArray<SLCourseExperList *> *list;

@end

@interface SLCourseExperList : NSObject
/** 特惠卡code */
@property (nonatomic, copy) NSString *course_code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSArray<SLGoods_ListM *> *goods_list;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<SLPro_ListM *> *pro_list;

@end

@interface SLGoods_ListM : XMHExperienceOrderBaseModel

@property (nonatomic, copy) NSString *goods_code;

//@property (nonatomic, assign) NSInteger num; 剩余数量

@property (nonatomic, assign) NSInteger numDisplay;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

//@property (nonatomic, copy) NSString *inputPrice;

@property (nonatomic, assign) NSInteger shichang;
@property (nonatomic, strong)SATicketModel *staicketModel;


@end

@interface SLPro_ListM : XMHExperienceOrderBaseModel

@property (nonatomic, copy) NSString *pro_code;

//@property (nonatomic, assign) NSInteger num; 剩余数量

@property (nonatomic, assign) NSInteger numDisplay;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

//@property (nonatomic, copy) NSString *inputPrice;

@property (nonatomic, assign) NSInteger shichang;
@property (nonatomic, strong)SATicketModel *staicketModel;


@end



