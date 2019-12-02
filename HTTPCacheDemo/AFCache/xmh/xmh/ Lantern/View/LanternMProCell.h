//
//  LanternMProCell.h
//  xmh
//
//  Created by ald_ios on 2019/2/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanternMProCell : UICollectionViewCell
@property (nonatomic, copy)void (^LanternMProCellBlock)(NSMutableDictionary *param);
- (void)updateCellParam:(NSMutableDictionary *)param islast:(BOOL)islast;
- (void)updateCellParam:(NSMutableDictionary *)param;
@end

NS_ASSUME_NONNULL_END
