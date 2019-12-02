//
//  XMHAwardContentCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/1.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHAwardContentCell : UITableViewCell
@property (nonatomic, copy)void(^selectedAwardType)(SaleModel *model);
- (void)refreshCellModel:(SaleModel *)model;

@end

NS_ASSUME_NONNULL_END
