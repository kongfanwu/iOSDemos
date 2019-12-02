//
//  XMHCouponCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SATicketModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponCell : UITableViewCell
@property (nonatomic, copy)void(^selectedDetail)(SATicketModel *model);
- (void)updateCellModel:(SATicketModel *)model cellType:(NSInteger )tag;
@end

NS_ASSUME_NONNULL_END
