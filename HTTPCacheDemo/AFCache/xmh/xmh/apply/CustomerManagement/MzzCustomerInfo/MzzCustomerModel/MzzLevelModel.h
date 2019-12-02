//
//  MzzLevelModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MzzFilterBaseModel.h"

@class MzzCustomerLevelModel;

@interface LevelData : NSObject

@property (nonatomic, strong) NSMutableArray<MzzCustomerLevelModel *> *group_list;
@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *end_date;

@end

@interface MzzCustomerLevelModel : MzzFilterBaseModel

@property (nonatomic, assign) NSInteger key;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger fid;

@property (nonatomic, assign) NSInteger glgk;

@property (nonatomic, assign) NSInteger glgk_bfb;

@property (nonatomic, assign) NSInteger hdgk;

@property (nonatomic, assign) NSInteger hdgk_bfb;

@property (nonatomic, assign) NSInteger yxgk;

@property (nonatomic, assign) NSInteger yxgk_bfb;

@property (nonatomic, copy) NSString *inId;

@property (nonatomic, assign) NSInteger fram_id;

@property (nonatomic, assign) NSInteger fram_name_id;

@property (nonatomic ,assign)NSInteger level;

@property (nonatomic, assign) NSInteger main_role;

@end
