//
//  LanternMYuanGongCell.h
//  xmh
//
//  Created by ald_ios on 2019/2/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LanternMYuanGongCell : UITableViewCell
- (void)updateCellParam:(NSMutableArray *)param;
- (void)updateSearchType:(BOOL)isFilter;
@property (nonatomic, copy)void(^LanternMYuanGongCellBlock)(NSMutableDictionary *param);
//- (void)updateCellParam:(NSMutableArray *)param cellHeight:(CGFloat)cellHeight;
- (void)updateCellModule:(NSString *)module;
- (void)updateCellHeight:(CGFloat)cellHeight;
+ (CGFloat)cellHeight:(NSArray *)dataArr count:(CGFloat)count;
@end

NS_ASSUME_NONNULL_END
