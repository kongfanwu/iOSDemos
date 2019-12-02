//
//  COrganizeModel.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/20.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "COrganizeModel.h"

@implementation COrganizeModel
+ (instancetype)createModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo startTime:(NSString *)startTime endTime:(NSString *)endTime{
    COrganizeModel * model = [[COrganizeModel alloc] init];
    model.oneClick = oneClick;
    model.twoClick = twoClick;
    model.twoListId = twoListId;
    model.joinCode = joinCode;
    model.thirdClick = thirdClick;
    model.forthClick = forthClick;
    model.level = level;
    model.inId = inId;
    model.main_role = mainrole;
    model.listInfo = listInfo;
    return model;
}
+ (instancetype)createModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole
{
    COrganizeModel * model = [[COrganizeModel alloc] init];
    model.oneClick = oneClick;
    model.twoClick = twoClick;
    model.twoListId = twoListId;
    model.joinCode = joinCode;
    model.thirdClick = thirdClick;
    model.forthClick = forthClick;
    model.level = level;
    model.main_role = mainrole;
    model.inId = inId;
    return model;
}
- (void)updateModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo startTime:(NSString *)startTime endTime:(NSString *)endTime
{
    _oneClick = oneClick;
    _twoClick = twoClick;
    _twoListId = twoListId;
    _joinCode = joinCode;
    _thirdClick = thirdClick;
    _forthClick = forthClick;
    _level = level;
    _inId = inId;
    _start = startTime;
    _end = endTime;
    _main_role = mainrole;
    _listInfo = listInfo;
}
- (void)updateModelWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    [self updateModelWithOneClick:_oneClick twoClick:_twoClick twoListId:_twoListId inId:_inId thirdClick:_thirdClick forthClick:_forthClick joinCode:_joinCode level:_level mainrole:_main_role listInfo:nil startTime:startTime endTime:endTime];
}
- (void)updateModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId thirdClick:(NSString *)thirdClick forthClick:(NSString *)forthClick joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo
{
    [self updateModelWithOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId thirdClick:thirdClick forthClick:forthClick joinCode:joinCode level:level mainrole:mainrole listInfo:listInfo startTime:_start endTime:_start];
}
- (void)updateModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId joinCode:(NSString *)joinCode level:(NSInteger)level mainrole:(NSInteger)mainrole listInfo:(List *)listInfo
{
    [self updateModelWithOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId thirdClick:_thirdClick forthClick:_forthClick joinCode:joinCode level:level mainrole:mainrole listInfo:listInfo startTime:_start endTime:_end];
}
- (void)updateOrganizeModel:(COrganizeModel *)model
{
    _oneClick = model.oneClick;
    _twoClick = model.twoClick;
    _twoListId = model.twoListId;
    _joinCode = model.joinCode;
    _thirdClick = model.thirdClick;
    _forthClick = model.forthClick;
    _level = model.level;
    _inId = model.inId;
    _start = model.start;
    _end = model.end;
    _main_role = model.main_role;
    _listInfo = model.listInfo;
}
@end
