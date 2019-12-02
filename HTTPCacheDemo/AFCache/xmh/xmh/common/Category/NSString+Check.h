//
//  NSString+Check.h
//  iCard
//
//  Created by weilihua on 14-6-16.
//  Copyright (c) 2014年 woaika.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// 一位整数。或者一位整数+一位小数 如： 9、1.2
#define XMHRegexOneNumOneFloat @"^[0-9]{1}+(\\.[0-9]{0,1})?$"

@interface NSString (Check)

/**
 *  检测输入的是否是字母或数字
 *
 *
 */
- (BOOL)isAlphaAndNum;

/**
 *  检测是否是字母
 *
 * 
 */
- (BOOL)isAlpha;

/**
 *  检测是否是数字
 *
 *
 */
- (BOOL)isNumbers;

/**
 *  检测是否是数字
 *
 *
 */
- (BOOL)isNumbersPeriod;

/**
 *  检测是否是有效邮箱地址
 *
 *
 */
- (BOOL)isEmail;

/**
 *  检测是否是有效身份证号
 *
 *
 */
- (BOOL)isIdentityCard;

/**
 *  检测是否是手机号码（包含170）
 *
 *
 */
- (BOOL)isMobileNumber;

/**
 *  是否是有效的信用卡卡号
 *
 *
 */
- (BOOL)isValidCreditCardNumber;

/*
 *  密码介于6-10位之间
 */
- (BOOL)isValidPassword;

/**
 *  是否是有效的验证码
 *
 *
 */
- (BOOL)isValidPassCode;

/**
 *  是否是有效的中文名字
 *
 *
 */
- (BOOL)isValidChineseName;

/**
 *  是否包含中文字符
 *
 *
 */
- (BOOL)hasChineseCharacter;

/**
 *  字符串的文字格式
 *
 *
 */
- (long)countOfWord;

/**
 *  判断字符串是否为空
 *
 *  @param  string  需要判断的字符串
 *
 */
+ (BOOL)isEmpty:(NSString *)string;

/**
 *  去除字符串两头的空格
 *
 *
 */
- (NSString *)trim;

/**
 返回 mobile 字段安全手机号。
 
 @return string
 */
- (NSString *)safeMobile;

/**
 是否是小数点后1位浮点数
 
 @param money 浮点数
 @return YES:是
 */
+ (BOOL)validateMoney:(NSString *)money;

/**

 正则校验
 
 @param regex 正则表达式
 @return YES 成功
 */
- (BOOL)evaluateRegex:(NSString *)regex;
/*
 用于UITextField输入限制
 基本数据类型或保留1位或2位小数都为YES。其他为NO
*/
- (BOOL)isVerifyPrice;


@end
