//
//  XMHOutComeFactory.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/13.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHSmartManagerEnum.h"
#import "XMHOutComeProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@class LMsgModel;
@interface XMHOutComeFactory : NSObject

/** 已读消息 */
@property (nonatomic, strong) NSMutableArray *readMessages;

+ (instancetype)sharedInstance;
/**
 构造器

 @param msgModel LMsgModel
 @return 控制器
 */

/**
  构造器

 @param msgModel LMsgModel
 @param pushUserInfo 友盟推送信息
 @param isUMPush 判断是否是友盟推送 .默认NO
 @return 控制器
 */
+(id)createOutComeVCMsgModel:(LMsgModel *__nullable)msgModel pushUserInfo:(NSDictionary *__nullable)pushUserInfo isUMPush:(BOOL)isUMPush;

- (void)addReadMessage:(LMsgModel *)msgModel;
@end

NS_ASSUME_NONNULL_END
