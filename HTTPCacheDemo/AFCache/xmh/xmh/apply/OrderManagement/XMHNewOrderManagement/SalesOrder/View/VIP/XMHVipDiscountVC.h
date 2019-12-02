//
//  XMHVipDiscountVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/22.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZheKouStored_Card;
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHVipDiscountVC : UIViewController
@property (nonatomic, strong) NSMutableDictionary *params;//请求参数
@property (nonatomic, strong) ZheKouStored_Card *zhekouModel;//选中的vip会员优惠
@property (nonatomic, copy)void(^selectedModel)(ZheKouStored_Card *model);
@property (nonatomic, strong)SaleModel *detailModel; //对应项目
@end

NS_ASSUME_NONNULL_END
