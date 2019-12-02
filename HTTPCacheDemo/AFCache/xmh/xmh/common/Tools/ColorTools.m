//
//  ColorTools.m
//  iCardGod
//
//  Created by lujunjing on 16/08/10.
//  Copyright (c) 2014年 51credit.com. All rights reserved.
//   颜色工具类

#import "ColorTools.h"

@implementation ColorTools


//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if (cString.length < 6)
    {
        return [UIColor blackColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length != 6)
    {
        return [UIColor blackColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //   OutLog(@"r=%f,g=%f,b=%f",(float)r,(float)g,(float)b);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorCauseByText:(NSString *)text
{
    if ([text isEqualToString:@"消费不足"]||[text isEqualToString:@"消耗不足"]||[text isEqualToString:@"规划未到店"]||[text isEqualToString:@"过度消费"]||[text isEqualToString:@"低频消耗"]) {
        return [ColorTools colorWithHexString:@"#ff9072"];
    }else if ([text isEqualToString:@"已流失"]||[text isEqualToString:@"待沟通"]||[text isEqualToString:@"即将休眠"]||[text isEqualToString:@"即将流失"]||[text isEqualToString:@"待叠加消费"]){
        return [ColorTools colorWithHexString:@"#ffaf19"];
    }else if ([text isEqualToString:@"购买已下架"]){
        return kLabelText_Commen_Color_9;
    }else if ([text isEqualToString:@"顾客生日"]||[text isEqualToString:@"节日跟进"]){
        return [ColorTools colorWithHexString:@"#ff97ce"];
    }else if ([text isEqualToString:@"审批中"]) {
        return [ColorTools colorWithHexString:@"#f3b337"];
    }else if ([text isEqualToString:@"已拒绝"]){
        return [ColorTools colorWithHexString:@"#f86f5c"];
    }else if ([text isEqualToString:@"已撤销"]){
        return [ColorTools colorWithHexString:@"#999999"];
    }else if ([text isEqualToString:@"已通过"]){
        return [ColorTools colorWithHexString:@"#48c2af"];
    }else if ([text isEqualToString:@"休息"]){
        return kLabelText_Commen_Color_6;
    }else if ([text isEqualToString:@"达标"]){
        return [ColorTools colorWithHexString:@"#48C2AF"];
    }else if ([text isEqualToString:@"不达标"]){
        return [ColorTools colorWithHexString:@"#FF9072"];
    }else if ([text isEqualToString:@"未完成"]){
        return [ColorTools colorWithHexString:@"#F3B337"];
    }else if ([text isEqualToString:@"已完成"]){
        return [ColorTools colorWithHexString:@"#CCCCCC"];
    }else if ([text isEqualToString:@"已终止"]){
        return [ColorTools colorWithHexString:@"#FF9072"];
    }
    
    return kBackgroundColor;
}
@end
