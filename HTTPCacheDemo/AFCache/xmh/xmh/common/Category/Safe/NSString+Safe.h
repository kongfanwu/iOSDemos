//
//  NSString+Safe.h
//  KuaiQi
//
//  Created by ducaiyan on 2018/9/12.
//  Copyright © 2018年 LeYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safe)

- (NSString *)safeSubstringToIndex:(NSUInteger)to;
- (NSString *)safeSubstringFromIndex:(NSUInteger)from;
- (NSString *)safeSubstringWithRange:(NSRange)range;
- (BOOL)safeHasPrefix:(NSString *)str;

@end
