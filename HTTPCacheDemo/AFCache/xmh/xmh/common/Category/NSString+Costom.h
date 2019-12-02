//
//  NSString+Costom.h
//  iCardGod
//
//  Created by weilihua on 15/8/6.
//  Copyright (c) 2015年 51credit.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Costom)

//获取字符串宽度
- (CGFloat)stringWidthWithFont:(UIFont *)font;
//获取字符串高度
- (CGSize)stringHeightWithFont:(UIFont *)font
                         width:(float)width;

//汉字转拼音
- (NSString *)transformToPinyin;

/**
 *  url编码
 */
- (NSString *)urlEncodingString;

//转码
- (NSString *)encodeToPercentEscapeString;
/**
 *  url解码
 */
+ (NSString *)urlDecodeString:(NSString*)encodedString;

//解码
- (NSString *)decodeFromPercentEscapeString;

// 字符串变化加单位
- (NSString *)stringToStringUnit;

// 获取文字（汉字）长度
- (NSInteger)stringWordsCount;

//json格式字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 iOS小数点格式化：如果有两位小数不为0则保留两位小数，如果有一位小数不为0则保留一位小数，否则显示整数
 
 @param f 浮点数
 @return 格式化后的字符串
 */
+ (NSString *)formatFloat:(float)f;
@end
