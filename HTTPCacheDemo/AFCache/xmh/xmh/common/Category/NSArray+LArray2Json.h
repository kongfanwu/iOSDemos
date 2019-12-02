//
//  NSArray+LArray2Json.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/25.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//



@interface NSArray (LArray2Json)
- (NSMutableString *)arr2Json:(NSArray *)arr;
@property (nonatomic ,copy)NSMutableString *jsonData;
@end
