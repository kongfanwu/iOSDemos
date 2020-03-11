//
//  FTFormUniversalConversion.h
//  FTFormDemo
//
//  Created by KFW on 2019/9/13.
//  Copyright © 2019 KFW. All rights reserved.
// 万能转换器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTFormUniversalConversion : NSObject

/** <##> */
@property (nonatomic, weak) FTFormRow *row;

/** 对value 进行转换操作 */
@property (nonatomic, copy) NSString * (^conversionValueBlock)(FTFormRow *row);

/**
 转换Value
 */
- (NSString *)conversionValue;


/** 获取表单转换操作 */
@property (nonatomic, copy) NSDictionary * (^conversionParamBlock)(FTFormRow *row);

/**
 获取表单转换
 */
- (NSDictionary *)conversionParam;

@end

NS_ASSUME_NONNULL_END
