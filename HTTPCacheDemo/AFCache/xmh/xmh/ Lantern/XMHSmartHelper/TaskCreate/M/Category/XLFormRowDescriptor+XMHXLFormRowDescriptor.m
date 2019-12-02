//
//  XLFormRowDescriptor+XMHXLFormRowDescriptor.m
//  xmh
//
//  Created by kfw on 2019/6/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XLFormRowDescriptor+XMHXLFormRowDescriptor.h"

@implementation XLFormRowDescriptor (XMHXLFormRowDescriptor)

NSString const *XMHXLFormActionValueTransformerInstanceKey = @"valueTransformerInstance";
- (void)setValueTransformerInstance:(NSValueTransformer *)valueTransformerInstance {
    [self willChangeValueForKey:@"valueTransformerInstance"]; // KVO
    objc_setAssociatedObject(self, &XMHXLFormActionValueTransformerInstanceKey, valueTransformerInstance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"valueTransformerInstance"]; // KVO
}

- (NSValueTransformer *)valueTransformerInstance {
    return objc_getAssociatedObject(self, &XMHXLFormActionValueTransformerInstanceKey);
}

/**
 返回转换后的text

 @return text
 */
- (NSString *)valueTransformerDisplayText {
    if (self.valueTransformer || self.valueTransformerInstance){
        NSValueTransformer * valueTransformer = self.valueTransformerInstance ? self.valueTransformerInstance : [self.valueTransformer new];
        id value = nil;
        if ([self.value conformsToProtocol:@protocol(XLFormOptionObject)]){
            value = [(id<XLFormOptionObject>)self.value formValue];
        } else {
            value = self.value;
        }
        NSString * tranformedValue = [valueTransformer transformedValue:value];
        if (tranformedValue) return tranformedValue;
    }
    else if ([self.value conformsToProtocol:@protocol(XLFormOptionObject)]){
        return [(id<XLFormOptionObject>)self.value formDisplayText];
    }
    
    return self.value;
}

@end
