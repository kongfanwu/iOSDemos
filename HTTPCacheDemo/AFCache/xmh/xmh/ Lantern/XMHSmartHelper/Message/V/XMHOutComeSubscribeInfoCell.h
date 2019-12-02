//
//  XMHOutComeSubscribeInfoCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHExecutionResultModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XMHOutComeSubscribeInfoCell : UITableViewCell
- (void)configureWithModel:(XMHExecutionResultModel *)model;
@end

NS_ASSUME_NONNULL_END
