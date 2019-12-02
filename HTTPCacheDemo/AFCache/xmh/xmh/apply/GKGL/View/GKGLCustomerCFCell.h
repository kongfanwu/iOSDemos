//
//  GKGLCustomerCFCell.h
//  xmh
//
//  Created by ald_ios on 2019/1/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLCustomerCFCell : UITableViewCell
@property (nonatomic, copy)void (^GKGLCustomerCFCellTapBlock)(NSDictionary *param);
- (void)updateCellParam:(NSDictionary *)param cellType:(NSInteger )tag;
@end

NS_ASSUME_NONNULL_END
