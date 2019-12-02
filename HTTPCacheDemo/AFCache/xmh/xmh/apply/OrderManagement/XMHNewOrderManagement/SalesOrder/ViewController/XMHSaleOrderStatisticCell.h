//
//  XMHSaleOrderStatisticCell.h
//  xmh
//
//  Created by 杜彩艳 on 2019/3/31.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleModel;
@class XMHBillRecoveryStatiscModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSaleOrderStatisticCell : UITableViewCell

@property (nonatomic, copy) NSString *yingfuPrice;// 补齐项目(逆向开单)应付金额
@property (nonatomic, assign) BOOL buYeji;// 补齐业绩
- (void)refresCellModelArr:(NSArray *)modelArr;
//账单回收
- (void)refresCellBillRecoverModelArr:(NSArray *)modelArr;
@end

NS_ASSUME_NONNULL_END
