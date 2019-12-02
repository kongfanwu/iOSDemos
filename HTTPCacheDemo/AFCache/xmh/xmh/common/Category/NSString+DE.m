//
//  NSString+DE.m
//  iCardGod
//
//  Created by weilihua on 15/5/25.
//  Copyright (c) 2015年 51credit.com. All rights reserved.
//

#import "NSString+DE.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "Base64.h"

#define EncryptKey  @""

@implementation NSString (DE)

static Byte iv[8]={1,2,3,4,5,6,7,8};

#pragma mark -
#pragma mark Public Method

// 控制加密
- (NSString *)isEncryptWithDes
{
    if (ISENCRYWITHDES) {
        return [self encrypt:self
            encryptOrDecrypt:kCCEncrypt
                         key:EncryptKey];
    } else {
        return self;
    }
}

// DES加密
- (NSString*)encryptWithDes
{
    return [self encrypt:self
        encryptOrDecrypt:kCCEncrypt
                     key:EncryptKey];
}

// 控制解密
- (NSString *)isDecryptWithDes
{
    return ISENCRYWITHDES ? [self encrypt:self
        encryptOrDecrypt:kCCDecrypt
                                      key:EncryptKey] : self;
}

//DES解密
- (NSString*)decryptWithDes
{
    return [self encrypt:self
        encryptOrDecrypt:kCCDecrypt
                     key:EncryptKey];
}

//MD5加密
- (NSString*)encryptWithMd5
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

#pragma mark -
#pragma mark Private Method

//加密解密方法
- (NSString *)encrypt:(NSString *)sText
     encryptOrDecrypt:(CCOperation)encryptOperation
                  key:(NSString *)key
{
    const void *dataIn;
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
    {
        //解码 base64
        NSData *decryptData = [Base64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        //        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    //    NSString *initIv = @"12345678";
    const void *vkey = (const void *) [key UTF8String];
    //    const void *iv = (const void *) [initIv UTF8String];
    
    
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(encryptOperation,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
    {
        //得到解密出来的data数据，改变为utf-8的字符串
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    }
    else //encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
    {
        //编码 base64
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        //        result = [GTMBase64 stringByEncodingData:data];
        result = [Base64 stringByEncodingData:data];
    }
    
    return result;
}

@end
