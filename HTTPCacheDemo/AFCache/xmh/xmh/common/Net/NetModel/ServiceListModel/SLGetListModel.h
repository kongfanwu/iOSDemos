//
//  SLGetListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLDlistModel;

@interface SLGetListModel : NSObject

@property (nonatomic, assign) NSInteger pType;

@property (nonatomic, strong) NSMutableArray<SLDlistModel *> *dList;

@end

@interface SLDlistModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, strong) NSArray *goods_list;

@property (nonatomic, copy) NSString *etime;

@property (nonatomic, copy) NSString *zt;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *stime;

@property (nonatomic, copy) NSString *type_name;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, strong) NSArray<NSString *> *pro_list;

@property (nonatomic, copy) NSString *inper_name;

@property (nonatomic, copy) NSString *zt_name;

@property (nonatomic, copy) NSString *z_price;
@property (nonatomic, copy)NSString * store_code;

@property (nonatomic, copy) NSString *inper;
//除顾客以上的需要字段
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger fram_id;
@property (nonatomic, assign) NSInteger fram_name_id;
@property (nonatomic, copy) NSString *inId;
@property (nonatomic, assign) NSInteger sum;
@property (nonatomic, assign) NSInteger price;

@property (nonatomic ,assign)BOOL isShow;
@property (nonatomic ,assign)int img;

@end


