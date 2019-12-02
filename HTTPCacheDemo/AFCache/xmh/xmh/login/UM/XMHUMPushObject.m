//
//  XMHUMPushObject.m
//  xmh
//
//  Created by 杜彩艳 on 2019/6/2.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHUMPushObject.h"

@implementation XMHUMPushObject

@end
@implementation XMHUMPushMediaMessage

+ (XMHUMPushMediaMessage *)message
{
    static dispatch_once_t onceToken;
    static XMHUMPushMediaMessage *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[XMHUMPushMediaMessage alloc] init];
    });
    return instance;
}

@end

@implementation XMHUMPushTextObject

+(XMHUMPushTextObject *) object
{
    static dispatch_once_t onceToken;
    static XMHUMPushTextObject *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XMHUMPushTextObject alloc] init];
    });
    return instance;
}

@end

@implementation XMHUMPushMediaWebObject

+(XMHUMPushMediaWebObject *) object
{
    static dispatch_once_t onceToken;
    static XMHUMPushMediaWebObject *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XMHUMPushMediaWebObject alloc] init];
    });
    return instance;
}

@end


@implementation XMHUMPushMediaImageObject

+(XMHUMPushMediaImageObject *) object
{
    static dispatch_once_t onceToken;
    static XMHUMPushMediaImageObject *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XMHUMPushMediaImageObject alloc] init];
    });
    return instance;
}

@end

@implementation XMHUMPushMediaMusicObject

+(XMHUMPushMediaMusicObject *) object
{
    static dispatch_once_t onceToken;
    static XMHUMPushMediaMusicObject *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XMHUMPushMediaMusicObject alloc] init];
    });
    return instance;
}

@end


@implementation XMHUMPushMediaVideoObject

+(XMHUMPushMediaVideoObject *) object
{
    static dispatch_once_t onceToken;
    static XMHUMPushMediaVideoObject *instance;
    dispatch_once(&onceToken, ^{
        instance = [[XMHUMPushMediaVideoObject alloc] init];
    });
    return instance;
}

@end


