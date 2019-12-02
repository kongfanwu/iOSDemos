//
//  XMHFormSendDateTransformer.m
//  xmh
//
//  Created by kfw on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormSendDateTransformer.h"

@implementation XMHFormSendDateTransformer
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
    if (IsEmpty(value)) {
        return @"请选择具体发送时间";
    }
    return value;
}

- (nullable id)reverseTransformedValue:(nullable id)value {
    return @"reverseTransformedValue";
}
@end
