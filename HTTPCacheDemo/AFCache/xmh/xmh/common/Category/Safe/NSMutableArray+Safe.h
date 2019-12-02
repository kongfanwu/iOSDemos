//
//  NSMutableArray+Safe.h
//  KuaiQi
//
//  Created by ducaiyan on 2018/9/12.
//  Copyright © 2018年 LeYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index;
- (void)safeAddObject:(id)anObject;
- (void)safeAddObjectsFromArray:(NSArray *)otherArray;
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs;
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)safeRemoveObject:(id)anObject;
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)safeAddObjectWithoutRepetition:(id)anObject;// 确保同样的object只含有一份

@end
