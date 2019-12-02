//
//  COrganizeModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZuZhiChoiceModel.h"
#import "ZhuzhiModel.h"
@interface COrganizeModel : NSObject
@property (nonatomic, copy)NSString * oneClick;
@property (nonatomic, copy)NSString * twoClick;
@property (nonatomic, copy)NSString * twoListId;
@property (nonatomic, copy)NSString * inId;
@property (nonatomic, copy)NSString * joinCode;
@property (nonatomic, copy)NSString * thirdClick;
@property (nonatomic, copy)NSString * forthClick;
@property (nonatomic, assign)NSInteger level;
@property (nonatomic, assign)NSInteger main_role;
@property (nonatomic, copy)NSString * start;
@property (nonatomic, copy)NSString * end;
@property (nonatomic, copy)List*listInfo;
/**
 *  全部参数类方法
 */
+ (instancetype)createModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo startTime:(NSString *)startTime endTime:(NSString *)endTime;
+ (instancetype)createModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole;
/**
 *  全部参数实例方法
 */
- (void)updateModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo startTime:(NSString *)startTime endTime:(NSString *)endTime;
/**
 *  时间参数
 */
- (void)updateModelWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/**
 *  组织架构参数 —— 线上交易
 */
- (void)updateModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo;
/**
 *  组织架构参数
 */
- (void)updateModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo;
- (void)updateOrganizeModel:(COrganizeModel *)model;
@end
