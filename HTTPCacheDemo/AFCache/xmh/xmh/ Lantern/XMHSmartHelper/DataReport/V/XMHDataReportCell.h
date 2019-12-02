//
//  XMHDataReportCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHDataReportModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHDataReportCell : UITableViewCell
- (void)refreshCellWithModel:(XMHDataReportModel *)model;
@end

NS_ASSUME_NONNULL_END
