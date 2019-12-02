//
//  LWaitBookParamModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWaitBookParamModel : NSObject
@property (nonatomic, copy)NSString *oneClick;
@property (nonatomic, copy)NSString *twoClick;
@property (nonatomic, copy)NSString *twoListId;
@property (nonatomic, copy)NSString *joinCode;
@property (nonatomic, copy)NSString *inId;
+ (instancetype)createModelWithOneClick:(NSString *)oneClick twoClick:(NSString *)twoClick twoListId:(NSString *)twoListId joinCode:(NSString *)joinCode inId:(NSString *)inId;
@end
