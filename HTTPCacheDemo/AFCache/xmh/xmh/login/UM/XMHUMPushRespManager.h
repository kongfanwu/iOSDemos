//
//  XMHUMPushRespManager.h
//  xmh
//
//  Created by 杜彩艳 on 2019/6/2.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHUMPushObject.h"
NS_ASSUME_NONNULL_BEGIN
@protocol XMHUMPushRespManagerDelegate <NSObject>

@optional
/**
 使用 3D Touch 或查看详情后展示消息内容，支持图片、视频、音乐等。仅适用于 iOS 10 以上的设备
 */

- (void)managerDidRecvMessageMediaTextObject:(XMHUMPushObject *)object;
- (void)managerDidRecvMessageMediaImageObject:(XMHUMPushObject *)object;
- (void)managerDidRecvMessageMediaWebObject:(XMHUMPushObject *)object;
- (void)managerDidRecvMessageMediaMusicObject:(XMHUMPushObject *)object;
- (void)managerDidRecvMessageMediaVideoObject:(XMHUMPushObject *)object;

@end
@interface XMHUMPushRespManager : NSObject
@property (nonatomic, weak) id<XMHUMPushRespManagerDelegate> delegate;

+ (instancetype)sharedManager;

+(BOOL) handleOpenUserInfo:(NSDictionary *) userInfo;

@end

NS_ASSUME_NONNULL_END
