//
//  XMHSmartMessageCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LMsgModel;
@interface XMHSmartMessageCell : UITableViewCell

- (void)updateSmartMessageCellModel:(LMsgModel *)model;
@end

NS_ASSUME_NONNULL_END
