//
//  LanternMSearchCell.h
//  xmh
//
//  Created by ald_ios on 2019/2/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMSearchCell : UITableViewCell
@property (nonatomic, copy)void (^LanternMSearchCellDelBlock)(NSDictionary *param);
- (void)updateCellParam:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
