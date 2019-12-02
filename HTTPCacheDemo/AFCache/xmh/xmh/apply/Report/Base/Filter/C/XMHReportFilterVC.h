//
//  XMHReportFilterVC.h
//  xmh
//
//  Created by ald_ios on 2019/7/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BaseCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHReportFilterVC : BaseCommonViewController
/** 筛选结果 */
@property (nonatomic, copy) void (^XMHReportFilterVCBlock)(NSString * pidMerge);
@property (nonatomic, copy) void (^XMHReportEmpioyFilterVCBlock)(NSString * json);
/** 报表类型 */
@property (nonatomic) XMHBaseReportVCType reportType;
@end

NS_ASSUME_NONNULL_END
