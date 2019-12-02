//
//  XMHEarningSourceCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/6.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHEarningSourceListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHEarningSourceCell : UITableViewCell

- (void)configureWithModel:(XMHEarningSourceModel *)model rank:(NSInteger)rank;

@end

NS_ASSUME_NONNULL_END
