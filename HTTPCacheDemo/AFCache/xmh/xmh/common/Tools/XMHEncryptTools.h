//
//  XMHEncryptTools.h
//  xmh
//
//  Created by ald_ios on 2019/5/24.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//  URL 签名用

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHEncryptTools : NSObject

+ (NSString *)encryptbyParam:(NSMutableDictionary *)param;
@end

NS_ASSUME_NONNULL_END
