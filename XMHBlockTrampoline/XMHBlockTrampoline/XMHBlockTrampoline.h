//
//  XMHBlockTrampoline.h
//  XMHBlockTrampoline
//
//  Created by kfw on 2020/11/27.
//
/*
 介绍：此类是为了让 block 可以动态传参，代码拷贝自RAC框架
 注意：参数个数、参数类型、参数顺序要与传参的数组相对应
 
 使用示例：
 // block 参数个数、参数类型要与数组相同
 NSString *(^block)(NSString *, NSString *, NSString *) = ^NSString *(NSString *a, NSString *b, NSString *c){
     NSString *res = [NSString stringWithFormat:@"%@+%@+%@", a, b, c];
     NSLog(@"res = %@", res);
     return res;
 };;
 
 // 参数个数自定义
 NSArray *args = @[@"1", @"2", @"3"];

 // 返回值是block的返回值
 NSString * blockResult = [XMHBlockTrampoline invokeBlock:block withArguments:args];
 NSLog(@"blockResult = %@", blockResult);
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHBlockTrampoline : NSObject

+ (id)invokeBlock:(id)block withArguments:(NSArray *)arguments;

@end

NS_ASSUME_NONNULL_END
