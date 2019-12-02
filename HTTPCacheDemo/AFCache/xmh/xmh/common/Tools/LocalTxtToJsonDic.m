//
//  LocalTxtToJsonDic.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/18.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LocalTxtToJsonDic.h"

@implementation LocalTxtToJsonDic

+ (NSDictionary *)txtToJsonDicWithLocalTxtName:(NSString *)txtName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:txtName ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:&error];
    return jsonDic;
}
@end
