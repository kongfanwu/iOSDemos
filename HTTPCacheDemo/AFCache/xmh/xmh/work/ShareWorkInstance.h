//
//  ShareWorkInstance.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LolUserInfoModel.h"

@interface ShareWorkInstance : NSObject

@property(nonatomic ,assign)NSUInteger  btnTag;
@property(nonatomic ,assign)NSUInteger  SecondBtnTag;
@property(nonatomic ,assign)NSUInteger  ThirdBtnTag;
@property(nonatomic ,assign)NSUInteger  positionBtnTag;

@property(nonatomic ,copy)NSString *coneClick;
@property(nonatomic ,copy)NSString *ctwoClick;
@property(nonatomic ,copy)NSString *ctwoListId;
@property(nonatomic ,copy)NSString *cinId;
@property(nonatomic ,assign)NSUInteger level;
@property(nonatomic ,assign)NSUInteger main_role;
@property (nonatomic, assign)NSInteger  uid;
@property(nonatomic ,copy)NSString *store_code;
@property(nonatomic ,copy)NSString *join_code;
@property (nonatomic, assign) NSInteger fram_id;
@property(nonatomic ,strong)NSMutableArray *BeautyProjectList;

@property(nonatomic ,strong)NSMutableDictionary *plan;

@property(nonatomic ,copy)NSString *symptom;//处方诉求
@property(nonatomic ,copy)NSString *target;//处方理念

@property(nonatomic ,strong)Join_Code *share_join_code;
@property(nonatomic ,strong)Data *share_data;

@property(nonatomic ,assign)CGFloat  xiongshabiOrigin;//熊傻逼起点

@property (nonatomic, assign) CGFloat showW;
+ (ShareWorkInstance *)shareInstance;
+ (void)releaseInstance;
@end
