//
//  NSObject+MzzDicToJson.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MzzDicToJson)
-(NSString *)convertToJsonData:(NSDictionary *)dict;
@property (nonatomic ,copy)NSString *jsonData;
@end
