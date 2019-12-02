//
//  NSArray+LArray2Json.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/25.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "NSArray+LArray2Json.h"

@implementation NSArray (LArray2Json)
@dynamic jsonData;
- (NSMutableString *)arr2Json:(NSArray *)arr{
    NSString * str = @"";
    NSMutableString * mutStr;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    mutStr = [NSMutableString stringWithString:str];
    NSRange range = {0,str.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
-(NSMutableString *)jsonData{
    return [self arr2Json:self];
}
@end
