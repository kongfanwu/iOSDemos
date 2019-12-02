//
//  GKGLAddCustomerCell.h
//  xmh
//
//  Created by ald_ios on 2019/1/8.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKGLCellModel;
NS_ASSUME_NONNULL_BEGIN

@interface GKGLAddCustomerCell : UITableViewCell
@property (nonatomic, copy)void (^GKGLAddCustomerCellBlock)(GKGLCellModel *model);
- (void)updateGKGLAddCustomerCellModel:(GKGLCellModel *)model;
- (void)updateCellCustomerInfoParam:(NSDictionary *)param indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
