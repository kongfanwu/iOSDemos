//
//  XMHFormValueTransformer.m
//  xmh
//
//  Created by kfw on 2019/6/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormValueTransformer.h"

@implementation XMHFormValueTransformer

+ (instancetype)formValueTransformertRransformedValueBlock:(id(^)(id value))transformedValueBlock {
    XMHFormValueTransformer *obj = XMHFormValueTransformer.new;
    obj.transformedValueBlock = transformedValueBlock;
    return obj;
}

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    if (self.transformedValueBlock) {
        return self.transformedValueBlock(value);
    }
    return @"";
}

- (nullable id)reverseTransformedValue:(nullable id)value {
    return @"reverseTransformedValue";
}
@end
