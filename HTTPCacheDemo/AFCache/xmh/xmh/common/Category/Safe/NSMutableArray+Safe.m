//
//  NSMutableArray+Safe.m
//  KuaiQi
//
//  Created by ducaiyan on 2018/9/12.
//  Copyright © 2018年 LeYun. All rights reserved.
//

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

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

- (void)safeAddObject:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    
    [self addObject:anObject];
}

- (void)safeAddObjectsFromArray:(NSArray *)otherArray
{
    if (otherArray == nil) {
        return;
    }
    
    [self addObjectsFromArray:otherArray];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{   //(index >= [self count]) 这里index = 0 导致array不能正常添加
    if ((index >= [self count] && index != 0) || (anObject == nil)){
        return;
    }
    
    [self insertObject:anObject atIndex:index];
}

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs
{
    if (objects == nil || indexs == nil ) {
        return;
    }
    
    [self insertObjects:objects atIndexes:indexs];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index >= [self count]) {
        return;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)safeRemoveObject:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    if (![self containsObject:anObject]) {
        return;
    }
    
    [self removeObject:anObject];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= [self count] || !anObject) {
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)safeAddObjectWithoutRepetition:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    
    if ([self containsObject:anObject]) {
        return;
    }
    
    [self addObject:anObject];
}


@end
