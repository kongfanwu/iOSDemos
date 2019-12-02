//
//  BeautyCFCell.h
//  xmh
//
//  Created by ald_ios on 2019/3/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeautyCFCell : UITableViewCell
@property (nonatomic, copy)void (^BeautyCFCellCFReportBlock)(NSMutableDictionary *param);
@property (nonatomic, copy)void (^BeautyCFCellEndCFBlock)(NSMutableDictionary *param);
- (void)updateCellParam:(NSMutableDictionary *)param index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
