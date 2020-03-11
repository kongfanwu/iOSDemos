//
//  FTFormParamVerify.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/15.
//  Copyright © 2019 KFW. All rights reserved.
// 表单校验

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTFormParamVerifyResult : NSObject
/** 成功或失败 */
@property (nonatomic) BOOL success;
/** 消息 */
@property (nonatomic, copy) NSString *msg;
+ (instancetype)createSuccess:(BOOL)success msg:(NSString *)msg;
@end

@interface FTFormParamVerify : NSObject
/** <##> */
@property (nonatomic, weak) FTFormRow *row;

/** <#type#> */
@property (nonatomic, copy) FTFormParamVerifyResult * (^verifyBlock)(FTFormRow *row);

/**
 校验必填

 @return 校验结果
 */
- (FTFormParamVerifyResult *)verify;

@end

NS_ASSUME_NONNULL_END
