//
//  NSString+Safe.m
//  KuaiQi
//
//  Created by ducaiyan on 2018/9/12.
//  Copyright © 2018年 LeYun. All rights reserved.
//

#import "NSString+Safe.h"

@implementation NSString (Safe)

- (NSString *)safeSubstringToIndex:(NSUInteger)to
{
    if (to > [self length]) {
        return nil;
    }
    
    return [self substringToIndex:to];
}

- (NSString *)safeSubstringFromIndex:(NSUInteger)from
{
    if (from > [self length]) {
        return nil;
    }
    
    return [self substringFromIndex:from];
}

- (NSString *)safeSubstringWithRange:(NSRange)range
{
    if ((range.location + range.length) > self.length)
    {
        return nil; //会发生越界错误
    }
    
    return [self substringWithRange:range];
}

- (BOOL)safeHasPrefix:(NSString *)str
{
    if (!str) {
        return NO;
    }
    
    return [self hasPrefix:str];
}

@end
