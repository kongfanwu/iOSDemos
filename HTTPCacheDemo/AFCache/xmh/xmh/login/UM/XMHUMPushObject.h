//
//  XMHUMPushObject.h
//  xmh
//
//  Created by 杜彩艳 on 2019/6/2.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XMHUMPushMediaMessage;
NS_ASSUME_NONNULL_BEGIN

@interface XMHUMPushObject : NSObject
/** 推送消息的多媒体内容
 * @see RCSMediaMessage
 */
@property (nonatomic, strong) XMHUMPushMediaMessage* message;
@end
#pragma mark --
#pragma mark -- XMHUMPushMediaMessage

/*! @brief 推送消息结构体
 *
 * 用于友盟推送和XMH之间传递消息的多媒体消息内容
 */
@interface XMHUMPushMediaMessage : NSObject

+(XMHUMPushMediaMessage *) message;

/** 主标题
 * @note 仅适用iOS10以上设备
 */
@property (nonatomic, copy) NSString *title;
/** 副标题
 * @note 仅适用iOS10以上设备
 */
@property (nonatomic, copy) NSString *subtitle;
/** 任务描述
 *
 */
@property (nonatomic, copy) NSString *msgDescription;
/** 内容
 */
@property (nonatomic, copy) NSString   *content;

/**
 * 多媒体消息数据对象，可以为XMHUMPushTextObject、XMHUMPushMediaWebObject等。
 */
@property (nonatomic, strong) id        mediaObject;

@end

/*! @brief 多媒体消息中的文本对象.
 *
 */
@interface XMHUMPushTextObject : NSObject

/*! @brief 返回一个XMHUMPushTextObject对象
 *
 * @note 返回的XMHUMPushTextObject对象是自动释放的
 */
+(XMHUMPushTextObject *) object;
/**
 * 文本内容.
 */
@property (nonatomic, copy) NSString *text;

@end

/*! @brief 多媒体消息中的Web页面对象.
 *
 */
@interface XMHUMPushMediaWebObject : NSObject

/*! @brief 返回一个XMHUMPushMediaWebObject对象
 *
 * @note 返回的XMHUMPushMediaWebObject对象是自动释放的
 */
+(XMHUMPushMediaWebObject *) object;
/**
 * Web页面的URL
 */
@property (nonatomic, copy) NSString *pageURL;

@end

/*! @brief 多媒体消息中的图片对象.
 *
 */
@interface XMHUMPushMediaImageObject : NSObject

/*! @brief 返回一个XMHUMPushMediaImageObject对象
 *
 * @note 返回的XMHUMPushMediaImageObject对象是自动释放的
 */
+(XMHUMPushMediaImageObject *) object;
/**
 *  图片内容
 */
@property (nonatomic, strong) NSData *imageData;
/**
 * 图片URL
 */
@property (nonatomic, copy) NSString *imageURL;

@end

/*! @brief 多媒体消息中包含的音乐数据对象
 *
 * @note musicUrl和musicLowBandUrl成员不能同时为空。
 */
@interface XMHUMPushMediaMusicObject : NSObject

/*! @brief 返回一个XMHUMPushMediaMusicObject对象
 *
 * @note 返回的XMHUMPushMediaMusicObject对象是自动释放的
 */
+(XMHUMPushMediaMusicObject *) object;

/** 音乐网页的url地址
 *
 */
@property (nonatomic, retain) NSString *musicUrl;

/** 音乐lowband网页的url地址
 *
 */
@property (nonatomic, retain) NSString *musicLowBandUrl;

/** 音乐数据url地址
 *
 */
@property (nonatomic, retain) NSString *musicDataUrl;

/** 音乐lowband数据url地址
 *
 */
@property (nonatomic, retain) NSString *musicLowBandDataUrl;

@end

/*! @brief 多媒体消息中包含的视频数据对象
 *
 * @note videoUrl和videoLowBandUrl不能同时为空。
 */
@interface XMHUMPushMediaVideoObject : NSObject

/*! @brief 返回一个XMHUMPushMediaVideoObject对象
 *
 * @note 返回的XMHUMPushMediaVideoObject对象是自动释放的
 */
+(XMHUMPushMediaVideoObject *) object;

/** 视频网页的url地址
 * @videoUrl
 */
@property (nonatomic, retain) NSString *videoUrl;

/** 视频lowband网页的url地址
 * @videoLowBandUrl
 */
@property (nonatomic, retain) NSString *videoLowBandUrl;

@end
NS_ASSUME_NONNULL_END
