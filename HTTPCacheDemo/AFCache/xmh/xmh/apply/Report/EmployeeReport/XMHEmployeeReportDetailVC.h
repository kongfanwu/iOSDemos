//
//  XMHEmployeeReportDetailVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/5.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "TJCustomerListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHEmployeeReportDetailVC : BaseCommonViewController
/** 员工报表选中的员工 */
@property (nonatomic, strong)TJCustomerModel * customerModel;

/**
 初始化
 
 @param dateArr 时间段 必须是时间戳eg:@[@{start_time:开始的时间戳,end_time:结束的时间戳}]
 @param timeType 时间类型 day week month
 @return vc
 */
- (instancetype)initWithDateArr:(NSArray *)dateArr timeType:(NSString *)timeType;
@end

NS_ASSUME_NONNULL_END
