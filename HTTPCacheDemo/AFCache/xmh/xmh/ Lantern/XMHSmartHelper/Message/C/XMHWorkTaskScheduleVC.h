//
//  XMHWorkTaskScheduleVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "XMHSmartManagerEnum.h"
#import "XMHOutComeProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHWorkTaskScheduleVC : BaseCommonViewController<XMHOutComeProtocol>
/** 工作任务提醒 - 展示形式 */
@property (nonatomic, assign) WorkTaskScheduleType type;
/** 列表日期，格式：2019-06-10 */
@property (nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
