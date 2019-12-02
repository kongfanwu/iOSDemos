//
//  XMHFormTrackUserTransformer.m
//  xmh
//
//  Created by kfw on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTrackUserTransformer.h"

@implementation XMHFormTrackUserTransformer
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
    if (![value isKindOfClass:[NSArray class]]) nil;
    
    if ([value isKindOfClass:[NSArray class]] && (value == nil || ((NSArray *)value).count == 0)) {
        return @"请选择顾客";
    }
    return [NSString stringWithFormat:@"已选择%ld人", ((NSArray *)value).count];
}

- (nullable id)reverseTransformedValue:(nullable id)value {
    return @"reverseTransformedValue";
}
@end
