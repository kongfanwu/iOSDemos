//
//  NSObject+XMHMap.h
//  tableViewSepDemo
//
//  Created by kfw on 2019/12/2.
//  Copyright © 2019 神灯智能. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//typedef ValueType _Nonnull (^RACGenericReduceBlock)();

_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wstrict-prototypes\"") \
typedef NSArray * _Nonnull (^XMHReturnBlock)(id _Nullable (^block)());
_Pragma("clang diagnostic pop")

@interface NSArray (XMHMap)  

/*
 类似 Swift map compactMap 函数。
 遍历数组并回调接受对象，将对象添加到新数组里，最后返回数组，
 
 示例 1 返回对象
 NSArray *arr = @[@"1", @"2", @"3"];
 NSMutableArray *result = arr.xmh_map(^id (id obj){
     return [NSString stringWithFormat:@"%@%@", obj, obj];
 });
 NSLog(@"result=%@", result); // 11 22  33
 
 示例 2 返回nil,过滤
 NSMutableArray *result2 = arr.xmh_map(^id (NSString *obj){
     return [obj isEqualToString:@"2"] ? nil : obj; // 返回 nil 过滤
 });
 NSLog(@"result2=%@", result2); // 1  3
 */
- (XMHReturnBlock)xmh_map;

/* 与 xmh_map 相同，增加索引
 NSArray *result2 = _arr.xmh_map2(^id (NSUInteger idx, NSString *obj) {
     return [obj isEqualToString:@"2"] ? nil : obj; // 返回 nil 过滤
 });
 */
- (NSArray *(^)(id _Nullable (^block)(NSUInteger, id)))xmh_map2;

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
- (NSInteger(^)(NSInteger initialResult, NSInteger(^block)(NSInteger x, NSInteger y)))xmh_reduce;


@end

NS_ASSUME_NONNULL_END
