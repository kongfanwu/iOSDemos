//
//  XMHFormTaskNextVCProtocol.h
//  xmh
//
//  Created by kfw on 2019/6/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 表单跳转下个VC.需要遵循此协议

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XMHFormTaskNextVCProtocol <NSObject>

@optional

/**
 配置参数
 */
- (void)configParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
