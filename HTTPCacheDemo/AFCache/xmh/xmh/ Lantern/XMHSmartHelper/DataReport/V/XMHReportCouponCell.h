//
//  XMHReportCouponCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHDataReportResultBaseCell.h"
/**
 优惠方式
 */
NS_ASSUME_NONNULL_BEGIN

@interface XMHReportCouponCell : XMHDataReportResultBaseCell

- (void)configureWithModel:(XMHExecutionResultModel *)model;
// 更新布局
- (void)updataMarkLine;
- (void)resetMarkLine;
@end

NS_ASSUME_NONNULL_END
