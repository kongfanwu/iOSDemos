//
//  XMHUMPushRespManager.m
//  xmh
//
//  Created by 杜彩艳 on 2019/6/2.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUMPushRespManager.h"
#import "XMHUMPushObject.h"

@implementation XMHUMPushRespManager
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static XMHUMPushRespManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XMHUMPushRespManager alloc] init];
    });
    return instance;
}
+(BOOL) handleOpenUserInfo:(NSDictionary *) userInfo
{
    XMHUMPushObject *pushObject = [[XMHUMPushObject alloc]init];
    XMHUMPushMediaMessage *mediaMessage =  [[XMHUMPushMediaMessage alloc]init];
    
    // 在这里处理推送的数据
    /*
    // 图片
    XMHUMPushMediaImageObject *imageObject = [XMHUMPushMediaImageObject object];
    imageObject.imageURL = userInfo[@"url"];
    mediaMessage.mediaObject = imageObject;
    // 网页
    XMHUMPushMediaWebObject *webObject = [XMHUMPushMediaWebObject object];
    webObject.pageURL = userInfo[@"url"];
    mediaMessage.mediaObject = webObject;
     */
    // 文本
    
    
    
    XMHUMPushTextObject *textObject = [XMHUMPushTextObject object];
    textObject.text = userInfo[@"content"];
    mediaMessage.mediaObject = textObject;
    
    pushObject.message = mediaMessage;
  
    [[XMHUMPushRespManager sharedManager] onReq: pushObject];
    return YES;

}
-(void) onReq:(XMHUMPushObject *)object{
    if ([object isKindOfClass:[XMHUMPushObject class]]) {
        XMHUMPushObject *messageReq = (XMHUMPushObject *)object;
        
        if ([messageReq.message.mediaObject isKindOfClass: [XMHUMPushTextObject class]]) {
            if (_delegate && [_delegate respondsToSelector:@selector(managerDidRecvMessageMediaTextObject:)]) {
                [_delegate managerDidRecvMessageMediaTextObject: messageReq];
            }
        }
        else if ([messageReq.message.mediaObject isKindOfClass: [XMHUMPushMediaImageObject class]]) {
            if (_delegate && [_delegate respondsToSelector:@selector(managerDidRecvMessageMediaImageObject:)]) {
                [_delegate managerDidRecvMessageMediaImageObject: messageReq];
            }
        }
        else if ([messageReq.message.mediaObject isKindOfClass: [XMHUMPushMediaWebObject class]]) {
            if (_delegate && [_delegate respondsToSelector:@selector(managerDidRecvMessageMediaWebObject:)]) {
                [_delegate managerDidRecvMessageMediaWebObject: messageReq];
            }
        }
        else if ([messageReq.message.mediaObject isKindOfClass: [XMHUMPushMediaMusicObject class]]) {
            if (_delegate && [_delegate respondsToSelector:@selector(managerDidRecvMessageMediaMusicObject:)]) {
                [_delegate managerDidRecvMessageMediaMusicObject: messageReq];
            }
        }
        else if ([messageReq.message.mediaObject isKindOfClass: [XMHUMPushMediaVideoObject class]]) {
            if (_delegate && [_delegate respondsToSelector:@selector(managerDidRecvMessageMediaVideoObject:)]) {
                [_delegate managerDidRecvMessageMediaVideoObject: messageReq];
            }
        }
    }
    
}
@end
