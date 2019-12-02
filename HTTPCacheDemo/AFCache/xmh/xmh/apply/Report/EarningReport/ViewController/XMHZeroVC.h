//
//  XMHZeroVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHZeroVC : BaseCommonViewController

/**
 初始化

 @param dateArr 时间段 必须是时间戳eg:@[@{start_time:开始的时间戳,end_time:结束的时间戳}]
 @param timeType 时间类型 day week month
 @param type 门店: XMHZeroTypeStore 员工:XMHZeroTypeEmployee
 @return vc
 */
- (instancetype)initWithDateArr:(NSArray *)dateArr timeType:(NSString *)timeType zeroType:(XMHZeroType)type;
@end

NS_ASSUME_NONNULL_END
