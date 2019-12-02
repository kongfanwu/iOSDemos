//
//  XMHFormValueTransformer.h
//  xmh
//
//  Created by kfw on 2019/6/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormValueTransformer : NSValueTransformer

/** <#type#> */
@property (nonatomic, copy) id (^transformedValueBlock)(id value);

+ (instancetype)formValueTransformertRransformedValueBlock:(id(^)(id value))transformedValueBlock;

@end

NS_ASSUME_NONNULL_END
