//
//  XMHFormTrackCouponTransformer.m
//  xmh
//
//  Created by kfw on 2019/6/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTrackCouponTransformer.h"

@implementation XMHFormTrackCouponTransformer
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
        return @"请选择优惠券";
    }
    return [NSString stringWithFormat:@"已选择%ld张", ((NSArray *)value).count];
}

- (nullable id)reverseTransformedValue:(nullable id)value {
    return @"reverseTransformedValue";
}
@end
