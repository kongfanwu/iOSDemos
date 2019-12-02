//
//  XMHCouponDetailView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/27.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SATicketModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHCouponDetailView : UIView
@property (nonatomic, copy)void(^selectedCouponsModel)(SATicketModel *ticketModel);
@property (nonatomic, strong)SATicketModel *model;//已选中的
/**
 初始化

 @param frame frame
 @param availaCouponArr 可使用优惠券数据
 @param unAavailaCouponArr 不可使用优惠券数据
 @return XMHCouponDetailView
 */
- (instancetype)initWithFrame:(CGRect)frame availaCouponArr:(NSMutableArray *)availaCouponArr unAavailaCouponArr:(NSMutableArray *)unAavailaCouponArr;
@end

NS_ASSUME_NONNULL_END
