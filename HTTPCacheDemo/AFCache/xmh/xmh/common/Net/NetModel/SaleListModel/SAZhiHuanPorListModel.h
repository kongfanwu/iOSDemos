//
//  SAZhiHuanPorListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SAZhiHuanPorModel;
@interface SAZhiHuanPorListModel : NSObject
@property (nonatomic, strong)NSArray <SAZhiHuanPorModel *>*list;
@end

@interface SAZhiHuanPorModel : NSObject

@property (nonatomic, assign)BOOL isShow;
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, copy)NSString * end_time;
@property (nonatomic, assign)NSInteger money;
@property (nonatomic, assign)NSInteger price;
@property (nonatomic, assign)NSInteger y_price;
@property (nonatomic, assign)NSInteger nums;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, copy)NSString * totalPrice;
@property (nonatomic, copy)NSString * intPutPrice;
@property (nonatomic, assign)BOOL isHuiShou;
@property (nonatomic, strong)NSArray *yy_basic;

@property (nonatomic, assign)NSInteger numDisPlay;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, assign)NSInteger xiaohao;
@property (nonatomic, assign)NSInteger fenqi_zt;
@property (nonatomic, assign)NSInteger user_card_id;
@property (nonatomic, assign)NSInteger card_id;
@property (nonatomic, copy)NSString * expiry;
@property (nonatomic, assign)NSInteger show_jz;

@property (nonatomic, assign)BOOL isQuanBuHuiShou;

@end
