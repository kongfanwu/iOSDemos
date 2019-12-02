//
//  SLS_ProModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SATicketListModel.h"
#import "SellProTicketListModel.h"
#import "XMHTicketModel.h"
#import "XMHExperienceOrderBaseModel.h"

@class SLS_Pro, MLJiShiModel;

@interface SLS_ProModel : NSObject

@property (nonatomic, strong) NSArray<SLS_Pro *> *list;

@end

@interface SLS_Pro : XMHExperienceOrderBaseModel

@property (nonatomic, copy) NSString *pro_code;

//@property (nonatomic, assign) NSInteger ID;

/** 项目时长 */
@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, copy) NSString *vip_price;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *r_price;

//@property (nonatomic, assign) NSInteger num;

//@property (nonatomic, copy) NSString *inputPrice;
@property (nonatomic, strong)SATicketModel *staicketModel;
@property (nonatomic, strong)SellProTicketModel *sellProModel;
@property (nonatomic, copy) NSString *diyongStr;
@property (nonatomic, copy) NSString *n_price;

@end


