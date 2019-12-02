//
//  XMHRankExpendCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHXiaohaoYeJiListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHRankExpendCell : UITableViewCell

/**
 cell赋值

 @param model XMHXiaohaoYeJiModel
 */
- (void)updateCellWithModel:(XMHXiaohaoYeJiModel *)model rank:(NSInteger)rank;
@end

NS_ASSUME_NONNULL_END
