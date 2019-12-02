//
//  lanternHistoryPlanListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/24.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LanternHistoryPlanModel;
@interface LanternHistoryPlanListModel : NSObject
@property (nonatomic, strong)NSArray <LanternHistoryPlanModel *>*list;
@end
@interface LanternHistoryPlanModel : NSObject
@property (nonatomic, copy)NSString *month;
@property (nonatomic, copy)NSString *consume;
@property (nonatomic, copy)NSString *expend;
@end
