//
//  NSArray+Safe.m
//  KuaiQi
//
//  Created by ducaiyan on 2018/9/12.
//  Copyright © 2018年 LeYun. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    
    return value;
}


@end
