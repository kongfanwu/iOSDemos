//
//  XMHVipDiscountDetailBaseView.h
//  xmh
//
//  Created by 杜彩艳 on 2019/4/13.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZheKouStored_Card;
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHVipDiscountDetailBaseView : UIView
@property (nonatomic, copy)void(^selectedModel)(ZheKouStored_Card *model);
@property (nonatomic, strong) ZheKouStored_Card *zhekouModel;//传入的选中的vip会员优惠
@property (nonatomic,strong)SaleModel *detailModel; //对应项目
/**
 初始化

 @param frame frame
 @param zheKouStoredCards 会员折扣数据
 @param model 已选的model
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame zheKouStoredCards:(NSMutableArray *)zheKouStoredCards model:(ZheKouStored_Card*)model;
@end

NS_ASSUME_NONNULL_END
