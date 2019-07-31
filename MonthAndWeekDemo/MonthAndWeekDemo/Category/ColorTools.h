//
//  ColorTools.h
//  iCardGod
//
//  Created by lujunjing on 16/08/10.
//  Copyright (c) 2014年 51credit.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorTools : NSObject


/**
 16进制颜色(html颜色值)字符串转为UIColor

 @param stringToConvert 16进制颜色

 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;


@end
