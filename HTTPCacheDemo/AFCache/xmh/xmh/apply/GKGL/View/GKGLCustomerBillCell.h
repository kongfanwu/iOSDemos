//
//  GKGLCustomerBillCell.h
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GKGLBillModel;
NS_ASSUME_NONNULL_BEGIN

@interface GKGLCustomerBillCell : UITableViewCell
@property (nonatomic, copy)void (^GKGLCustomerBillCellTapBlock)(NSDictionary *param,NSString *cardType);
- (void)updateGKGLCustomerBillCellModel:(GKGLBillModel *)model;
@end

NS_ASSUME_NONNULL_END
