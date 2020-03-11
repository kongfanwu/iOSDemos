//
//  FTFormAction.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/11.
//  Copyright © 2019 KFW. All rights reserved.
// push present 通用处理类

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FTFormActionModel) {
    FTFormActionModelPresent,
    FTFormActionModelPush,
};

NS_ASSUME_NONNULL_BEGIN

@interface FTFormAction : NSObject
/** vc */
@property (nonatomic) Class classVC;
/** 弹出模式 默认FTFormActionModelPresent */
@property (nonatomic) FTFormActionModel model;
/** 传的参数 */
@property (nonatomic, strong) NSDictionary *param;
@end

NS_ASSUME_NONNULL_END
