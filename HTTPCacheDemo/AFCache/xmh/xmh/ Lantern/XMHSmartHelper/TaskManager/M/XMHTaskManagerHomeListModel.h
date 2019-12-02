//
//  XMHTaskManagerHomeLIstModel.h
//  xmh
//
//  Created by ald_ios on 2019/6/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHTaskManagerHomeModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHTaskManagerHomeListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHTaskManagerHomeModel *> *list;
@end
@interface XMHTaskManagerHomeModel : NSObject
@property (nonatomic, copy)NSString *taskID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *num;
@property (nonatomic, copy)NSString *track_num;
/* 发送状态 1-执行中 2-执行完成 3-终止 */
@property (nonatomic, assign)NSInteger status;
@property (nonatomic, assign)NSInteger end_time;
@end
NS_ASSUME_NONNULL_END
