//
//  LanternMStoreCell.h
//  xmh
//
//  Created by ald_ios on 2019/2/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MzzStoreModel;
NS_ASSUME_NONNULL_BEGIN

@interface LanternMStoreCell : UITableViewCell
- (void)updateCellModel:(MzzStoreModel *)model;
- (void)updateCellParam:(NSMutableDictionary *)param;
@end

NS_ASSUME_NONNULL_END
