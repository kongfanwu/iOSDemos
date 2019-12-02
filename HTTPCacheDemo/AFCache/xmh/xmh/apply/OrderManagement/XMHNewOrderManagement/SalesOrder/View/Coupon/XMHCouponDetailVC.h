//
//  XMHCouponDetailVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
/**优惠券控制器*/
NS_ASSUME_NONNULL_BEGIN
@class SATicketModel;
@class SaleModel;
@interface XMHCouponDetailVC : UIViewController
@property (nonatomic, strong)SATicketModel *model;//已选中的
@property (nonatomic,strong)SaleModel *detailModel;
@property (nonatomic, copy)void(^selectedCouponsModel)(SATicketModel *ticketModel);
@property (nonatomic, strong) NSMutableDictionary *params;//请求参数

@end

NS_ASSUME_NONNULL_END
