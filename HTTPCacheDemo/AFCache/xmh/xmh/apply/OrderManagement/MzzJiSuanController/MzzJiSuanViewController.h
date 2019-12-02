//
//  MzzJiSuanViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/26.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SANewDingDanListModel.h"

@interface MzzJiSuanViewController : UIViewController
@property (nonatomic ,assign)YemianStyle yemianStyle;
@property (nonatomic,strong)SANewDingDanModel *Dingdanmodel;
- (void)setOrderNum:(NSString *)orderNum andYemianStyle:(YemianStyle )yemianStyle andType:(NSUInteger)type andUid:(NSString *)uid withName:(NSString *)name;
- (void)setFWDOrderNum:(NSString *)orderNum;
- (void)setOrderNum:(NSString *)orderNum  andZt:(NSString *)zt;
- (void)setOrderDic:(NSDictionary *)dic withType:(NSUInteger)type andYemianStyle:(YemianStyle )yemianStyle wiTitle:(NSString *)title;
- (void)setOrderDetailNum:(NSString *)orderNum andYemianStyle:(YemianStyle )yemianStyle;

@end
