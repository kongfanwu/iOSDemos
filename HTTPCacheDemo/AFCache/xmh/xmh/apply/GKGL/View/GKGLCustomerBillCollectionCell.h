//
//  GKGLCustomerBillCollectionCell.h
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLCustomerBillCollectionCell : UICollectionViewCell
@property (nonatomic, copy)void (^GKGLCustomerBillCollectionCellTapBlock)(NSDictionary *param);
- (void)updateGKGLCustomerBillCollectionCellParamDic:(NSDictionary *)param type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
