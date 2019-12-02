//
//  MzzCustomerInfoModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/15.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InfoModel;



@interface InfoModel : NSObject

@property (nonatomic, copy) NSString *area_name;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger imp;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, copy) NSString *jd_time;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *last_shop_time;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *store_name;

@property (nonatomic, copy) NSString *dao;

@property (nonatomic, copy) NSString *wx;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, assign) NSInteger grade;

@property (nonatomic, copy) NSString *grade_name;

@property (nonatomic, copy) NSString *post;

@property (nonatomic, copy) NSString *last_fw_time;

@property (nonatomic, copy) NSString *jis_name;

@property (nonatomic, copy) NSString *dao_name;

@property (nonatomic, copy) NSString *uid;
@end


