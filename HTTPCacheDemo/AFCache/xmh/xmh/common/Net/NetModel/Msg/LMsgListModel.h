//
//  LMsgListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/15.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LMsgModel;
@interface LMsgListModel : NSObject
@property (nonatomic,strong)NSArray <LMsgModel *>*list;
@end

@interface LMsgModel : NSObject
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * content;
@property (nonatomic, copy)NSString * time;
@property (nonatomic, copy)NSString * url;
/** 未读状态  未读:NO 已读:YES 默认未读*/
@property (nonatomic, assign)BOOL  unread;
@end
