//
//  MsgRequest.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "LMsgListModel.h"
#import "MsgHomeListModel.h"
@interface MsgRequest : NSObject
{
    NSURLSessionDataTask * _numTask;
    NSURLSessionDataTask * _msgListTask;
    NSURLSessionDataTask * _newMsgListTask;
}
/**
 *  消息未读数
 */
+ (void)requestUnReadNumParma:(NSMutableDictionary *)param resultBlock:(void(^)(BaseModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  消息列表
 */
+ (void)requestMsgListParam:(NSMutableDictionary *)param resultBlock:(void(^)(LMsgListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
/**
 *  新消息首页列表
 */
+ (void)requestNewHomeMsgListParam:(NSMutableDictionary *)param resultBlock:(void(^)(MsgHomeListModel *model, BOOL isSuccess, NSDictionary * errorDic))resultBlock;
@end
