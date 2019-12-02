//
//  NSString+Check.m
//  iCard
//
//  Created by weilihua on 14-6-16.
//  Copyright (c) 2014年 woaika.com. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

//检测是否是字母或数字
- (BOOL)isAlphaAndNum
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =
    [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = ([self isEqualToString:filtered] && ![self isNumbers]);
    return basic;
}

//检测是否是字母
- (BOOL)isAlpha
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlpha] invertedSet];
    NSString *filtered =
    [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [self isEqualToString:filtered];
    return basic;
}

//检测是否是数字
- (BOOL)isNumbers
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kNumbers] invertedSet];
    NSString *filtered =
    [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [self isEqualToString:filtered];
    return basic;
}

//检测是否是数字包括"."
- (BOOL)isNumbersPeriod
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kNumbersPeriod] invertedSet];
    NSString *filtered =
    [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [self isEqualToString:filtered];
    return basic;
}

//检测是否是有效邮箱地址
- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *email = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [email evaluateWithObject:self];
}

//身份证号
- (BOOL)isIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//检测是否是手机号码（包含170）
- (BOOL)isMobileNumber
{
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if (([regextestmobile evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|7[0-9]|8[01235-9])\\d{8}$";
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    if (([regextestmobile evaluateWithObject:self] == YES)
//        || ([regextestcm evaluateWithObject:self] == YES)
//        || ([regextestct evaluateWithObject:self] == YES)
//        || ([regextestcu evaluateWithObject:self] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

//是否是有效的信用卡卡号
- (BOOL)isValidCreditCardNumber
{
    NSInteger len = self.length;
    
    if (len < 13 || len > 19)
        return  NO;
    
    int sum = 0;
    
    /* 信用卡卡号规则验证
     * Issuer Identifier    Card Number                            Length
     * Diner’s Club         300xxx-305xxx, 3095xx,36xxxx, 38xxxx   14
     * American Express     34xxxx, 37xxxx                         15
     * VISA                 4xxxxx                                 13, 16
     * MasterCard           51xxxx-55xxxx                          16
     * JCB                  3528xx-358xxx                          16
     * Discover             6011xx                                 16
     * 银联                  622126-622925                          16
     * 算法
     * 1.偶数位卡号奇数位上数字*2，奇数位卡号偶数位上数字*2。
     * 2.大于等于10的位数减9。
     * 3.全部数字加起来。
     * 4.结果不是10的倍数的卡号非法。
     */
    for (NSInteger i = 0; i < len; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSInteger multiResult = 0;
        NSInteger number = [[self substringWithRange:range] integerValue];
        
        if (len % 2 == 0) {
            if (i % 2 == 0) {
                multiResult = number * 2;
                
                if (multiResult >= 10) multiResult -= 9;
                
                sum += multiResult;
            } else {
                sum += number;
            }
        } else {
            if (i % 2 == 1) {
                multiResult = number * 2;
                if (multiResult >= 10) multiResult -= 9;
                
                sum += multiResult;
            } else {
                sum += number;
            }
        }
    }
    if (sum % 10 == 0)
        return YES;
    
    return NO;
}


//密码介于8-16位之间
- (BOOL)isValidPassword
{
    NSString *passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:self];
}

//是否是有效的验证码
- (BOOL)isValidPassCode
{
    NSString *passCodeRegex = @"[0-9]{6}";
    NSPredicate *passCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passCodeRegex];
    return [passCodeTest evaluateWithObject:self];
}

//是否是有效的（1～10个）中文名字
- (BOOL)isValidChineseName
{
    NSString *nameRegex = @"^[\u4e00-\u9fa5]{1,10}$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:self];
}

//是否包含中文字符
- (BOOL)hasChineseCharacter
{
    NSString *nameRegex = @"^[\u4e00-\u9fa5]{2,4}";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:self];
}

// 字符个数
- (long)countOfWord
{
    NSInteger i,n=[self length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[self characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(long)ceilf((float)(a+b)/2.0);
}

// 检查字符串是否为空
+ (BOOL)isEmpty:(NSString *)string
{
    if (string==nil ||
        [string isEqualToString:@""] ||
        [string isEqualToString:@"NULL"] ||
        [string isEqualToString:@"(null)"] ||
        [string isEqualToString:@"nil"]) {
        return YES;
    }
    return NO;
}

// 去除两头的空格
- (NSString *)trim
{
    NSString *res = self;
    while ([res hasPrefix:@" "]) {
        res = [res substringFromIndex:1];
    }
    while ([res hasSuffix:@" "]) {
        res = [res substringToIndex:res.length-1];
    }
    return res;
}

/**
 返回 mobile 字段安全手机号。
 
 @return string
 */
- (NSString *)safeMobile {
    if (self.length == 11) {
        NSString *firstStr = [self substringToIndex:3];
        NSString *lastStr = [self substringFromIndex:7];
        return [NSString stringWithFormat:@"%@****%@", firstStr, lastStr];
    }
    return nil;
}

/**
 是否是小数点后1位浮点数

 @param money 浮点数
 @return YES:是
 */
+ (BOOL)validateMoney:(NSString *)money
{
    // {1,2} 代表小数点后1位或2位小数
    NSString *phoneRegex = @"^[0-9]+(\\.[0-9]{0,1})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}

/**

 正则校验

 @param regex 正则表达式
 @return YES 成功
 */
- (BOOL)evaluateRegex:(NSString *)regex {
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:self];
}
/*
 用于UITextField输入限制
 基本数据类型或保留1位或2位小数都为YES。其他为NO
 */
- (BOOL)isVerifyPrice {
    NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,9}(([.]\\d{0,2})?)))?";
    NSPredicate *identifyPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [identifyPredicate evaluateWithObject:self];

}

@end
