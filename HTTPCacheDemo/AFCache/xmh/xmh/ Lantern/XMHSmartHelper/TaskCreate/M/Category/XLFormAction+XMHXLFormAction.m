//
//  XLFormAction+XMHXLFormAction.m
//  xmh
//
//  Created by kfw on 2019/6/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XLFormAction+XMHXLFormAction.h"

@implementation XLFormAction (XMHXLFormAction)

NSString const *XMHXLFormActionNextParamsKey = @"nextParams";
- (void)setNextParams:(NSDictionary *)nextParams {
    [self willChangeValueForKey:@"nextParams"]; // KVO
    objc_setAssociatedObject(self, &XMHXLFormActionNextParamsKey, nextParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"nextParams"]; // KVO
}

- (NSDictionary *)nextParams {
    return objc_getAssociatedObject(self, &XMHXLFormActionNextParamsKey);
}

@end
