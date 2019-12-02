//
//  NSString+DE.h
//  iCardGod
//
//  Created by weilihua on 15/5/25.
//  Copyright (c) 2015年 51credit.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DE)

// 控制加密
- (NSString *)isEncryptWithDes;

// 控制解密
- (NSString *)isDecryptWithDes;

/**
 *  DES加密
 *
 *  @return 加密后字符串
 */
- (NSString*)encryptWithDes;

/**
 *  DES解密
 *
 *  @return 解密后的字符串
 */
- (NSString*)decryptWithDes;

/**
 *  MD5加密
 *
 *  @return 加密后的字符串
 */
- (NSString*)encryptWithMd5;

@end
