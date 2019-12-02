//
//  SLGoodListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SATicketListModel.h"
#import "XMHTicketModel.h"
#import "XMHExperienceOrderBaseModel.h"
@class SLGoodModel;
@class MLJiShiModel;

@interface SLGoodListModel : NSObject

@property (nonatomic, strong) NSArray<SLGoodModel *> *list;

@end

@interface SLGoodModel : XMHExperienceOrderBaseModel

//@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *goods_code;

@property (nonatomic, copy) NSString *vip_price;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *r_price;

//@property (nonatomic, assign) NSInteger num;

//@property (nonatomic, copy) NSString *inputPrice;

/** 项目时长 */
@property (nonatomic, assign) NSInteger shichang;
/** 优惠卷 */
@property (nonatomic, strong)SATicketModel *staicketModel;

@end


