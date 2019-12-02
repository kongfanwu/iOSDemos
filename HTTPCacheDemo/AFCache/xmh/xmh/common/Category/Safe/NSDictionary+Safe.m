//
//  NSDictionary+Safe.m
//  KuaiQi
//
//  Created by ducaiyan on 2018/9/12.
//  Copyright © 2018年 LeYun. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (id)safeObjectForKey:(id)aKey
{
    if (aKey == nil) {
        return nil;
    }
    
    id value = [self objectForKey:aKey];
    if (value == [NSNull null]) {
        return nil;
    }
    
    return value;
}



@end
