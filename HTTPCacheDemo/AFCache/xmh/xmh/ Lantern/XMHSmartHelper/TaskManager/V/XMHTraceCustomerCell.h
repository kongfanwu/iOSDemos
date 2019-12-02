//
//  XMHTraceCustomerCell.h
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHSmartManagerEnum.h"
@class GKGLHomeCustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHTraceCustomerCell : UITableViewCell
- (void)updateCellModel:(GKGLHomeCustomerModel *)model;
- (void)updateCellType:(XMHTraceCustomerCellType)cellType;
@end

NS_ASSUME_NONNULL_END
