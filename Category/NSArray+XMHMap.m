//
//  NSObject+XMHMap.m
//  tableViewSepDemo
//
//  Created by kfw on 2019/12/2.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import "NSArray+XMHMap.h"

@implementation NSArray (XMHMap)

/*
 类似 Swift reduce 函数
 循环累加数值
 initialResult 初始值
 x 每次累加后的值
 y 每次循环数组元素

 示例
 NSArray *arr = @[@"1", @"2", @"3", @"4"];
 NSInteger sum = arr.xmh_reduce(0, ^NSInteger (NSInteger x, NSInteger y) {
     return x + y;
 });
 NSLog(@"sum = %ld", sum); // 10
*/
- (NSArray *(^)(id _Nullable (^block)(id)))xmh_map {
    return ^(id(^block)(id)) {
        NSMutableArray *list = NSMutableArray.new;
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id result = block(obj);
            if (result) [list addObject:result];
        }];
        return list;
    };
}

/* 与 xmh_map 相同，增加索引
 NSArray *result2 = _arr.xmh_map2(^id (NSUInteger idx, NSString *obj) {
     return [obj isEqualToString:@"2"] ? nil : obj; // 返回 nil 过滤
 });
*/
- (NSArray *(^)(id _Nullable (^block)(NSUInteger, id)))xmh_map2 {
    return ^(id(^block)(NSUInteger, id)) {
        NSMutableArray *list = NSMutableArray.new;
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id result = block(idx, obj);
            if (result) [list addObject:result];
        }];
        return list;
    };
}

/*
 类似 Swift reduce 函数
 循环累加数值
 initialResult 初始值
 x 每次累加后的值
 y 每次循环数组元素

 示例
 NSArray *arr = @[@"1", @"2", @"3", @"4"];
 NSInteger sum = arr.xmh_reduce(0, ^NSInteger (NSInteger x, NSInteger y) {
     return x + y;
 });
 NSLog(@"sum = %ld", sum); // 10
*/
- (NSInteger(^)(NSInteger initialResult, NSInteger(^block)(NSInteger x, NSInteger y)))xmh_reduce {
    return ^(NSInteger initialResult, NSInteger(^block)(NSInteger x, NSInteger y)) {
        __block NSInteger sum = initialResult;
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            sum = block(sum, [obj integerValue]);
        }];
        return sum;
    };
}



@end
