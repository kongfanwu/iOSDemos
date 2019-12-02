//
//  XMHTaskMangerHomeCell.h
//  xmh
//
//  Created by ald_ios on 2019/6/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHSmartManagerEnum.h"
@class XMHTaskManagerHomeModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHTaskMangerHomeCell : UITableViewCell
@property (nonatomic, copy) void (^XMHTaskMangerHomeCellSwitchBlock)(XMHTaskManagerHomeModel *obj, BOOL on);
- (void)updateCellType:(XMHTaskManagerCellType)cellType;
- (void)updateCellModel:(XMHTaskManagerHomeModel *)model;
@end

NS_ASSUME_NONNULL_END
