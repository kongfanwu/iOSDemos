//
//  StructureModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StructureModel : NSObject
@property (nonatomic, copy)NSString * oneClick;
@property (nonatomic, copy)NSString * twoClick;
@property (nonatomic, copy)NSString * twoListId;
@property (nonatomic, copy)NSString * inId;
@property (nonatomic, copy)NSString * startTime;
@property (nonatomic, copy)NSString * endTime;
@property (nonatomic, copy)NSString * urlStr;
@property (nonatomic, copy)NSString * token;
@property (nonatomic, copy)NSString * joinCode;
@property (nonatomic, assign)NSInteger type;
+ (instancetype)initWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId inId:(NSString *)inId startTime:(NSString *)startTime endTime:(NSString *)endTime urlStr:(NSString *)urlStr token:(NSString *)token joinCode:(NSString *)joinCode type:(NSInteger)type;
@end
