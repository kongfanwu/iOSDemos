//
//  XMHSegmentCell.h
//  xmh
//
//  Created by KFW on 2019/3/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHSegmentVCModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHSegmentCell : UITableViewCell

- (void)configModel:(XMHSegmentVCModel *)model;

@end

NS_ASSUME_NONNULL_END
