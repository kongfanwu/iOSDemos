//
//  LApproveQKModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/7.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LApproveQKModel : NSObject
@property (nonatomic, copy)NSString * userId;
@property (nonatomic, copy)NSString * joinCode;
@property (nonatomic, copy)NSString * storeCode;
+ (instancetype)createModelWithUserId:(NSString *)userId joinCode:(NSString *)joinCode storeCode:(NSString *)storeCode;
@end
