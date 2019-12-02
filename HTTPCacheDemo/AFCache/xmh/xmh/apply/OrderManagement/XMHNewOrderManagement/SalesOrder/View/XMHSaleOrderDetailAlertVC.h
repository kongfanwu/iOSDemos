//
//  XMHSaleOrderDetailAlertVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSaleOrderDetailAlertVC : UIViewController

@property (nonatomic, copy)void(^selectedSaleModel)(SaleModel *model);
/**
 初始化

 @param frame frame
 @param cardType 卡片类型
 @param detailModel 已选model
 @param userId userId
 @param storeCode 商品编码
 @return VC
 */
- (instancetype)initWithFrame:(CGRect)frame cardType:(NSString *)cardType detailModel:(SaleModel *)detailModel userId:(NSString *)userId storeCode:(NSString *)storeCode;
@end

NS_ASSUME_NONNULL_END
