//
//  XMHDataReportListModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHDataReportModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHDataReportListModel : NSObject

@property (nonatomic, strong)NSMutableArray <XMHDataReportModel *>*list;

@end

@interface XMHDataReportModel : NSObject
/** 任务名称 */
@property (nonatomic, copy)NSString *name;
/** id */
@property (nonatomic, copy)NSString *uid;
/** 时间 */
@property (nonatomic, copy)NSString *create_time;
/** 任务总次数 */
@property (nonatomic, copy)NSString *all;
/** 执行次数 */
@property (nonatomic, copy)NSString *zhi;
/** 已读未读状态 */
@property (nonatomic, copy)NSString *read;
@end

NS_ASSUME_NONNULL_END
