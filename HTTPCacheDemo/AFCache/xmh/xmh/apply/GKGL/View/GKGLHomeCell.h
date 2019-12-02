//
//  GKGLHomeCell.h
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKGLHomeCustomerModel;
NS_ASSUME_NONNULL_BEGIN

@interface GKGLHomeCell : UITableViewCell
- (void)updateGKGLHomeCellModel:(GKGLHomeCustomerModel *)model;
@end

NS_ASSUME_NONNULL_END
