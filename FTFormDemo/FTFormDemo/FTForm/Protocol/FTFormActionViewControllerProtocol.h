//
//  FTFormActionViewControllerProtocol.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/11.
//  Copyright © 2019 KFW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FTFormActionViewControllerProtocol <NSObject>
@required
/** 点击cell的row */
@property (nonatomic, strong) FTFormRow *row;

@optional

/**
 配置参数

 @param param 参数字典
 */
- (void)confitParam:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
