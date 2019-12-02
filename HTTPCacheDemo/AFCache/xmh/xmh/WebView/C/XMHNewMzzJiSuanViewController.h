//
//  XMHNewMzzJiSuanViewController.h
//  xmh
//
//  Created by KFW on 2019/4/4.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//
/*
 sales/detailsNew.html 销售单详情
 serv/detailsNew.html 服务单详情
 sales/payNew.html
 serv/payNew.html
 */

#import <UIKit/UIKit.h>
#import "SANewDingDanListModel.h"
#import "CustomerListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHNewMzzJiSuanViewController : UIViewController
@property (nonatomic ,assign)YemianStyle yemianStyle;
@property (nonatomic,strong)CustomerModel *customer;
- (void)setOrderNum:(NSString *)orderNum andYemianStyle:(YemianStyle )yemianStyle andType:(NSUInteger)type andUid:(NSString *)uid withName:(NSString *)name;
- (void)setFWDOrderNum:(NSString *)orderNum;
- (void)setOrderNum:(NSString *)orderNum  andZt:(NSString *)zt;
- (void)setOrderDic:(NSDictionary *)dic withType:(NSUInteger)type andYemianStyle:(YemianStyle )yemianStyle wiTitle:(NSString *)title;
- (void)setOrderDetailNum:(NSString *)orderNum andYemianStyle:(YemianStyle )yemianStyle;

/**返回订单首页*/
@property (nonatomic, copy)void(^popToOrderMainPageVC)();
/**结算入口 制单管理: 1; 订单管理: 0 默认是0*/
@property (nonatomic, assign) NSInteger  entrance;

@end

NS_ASSUME_NONNULL_END
