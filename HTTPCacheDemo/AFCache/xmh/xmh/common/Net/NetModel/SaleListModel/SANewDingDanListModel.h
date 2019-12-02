//
//  SANewDingDanListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved
//

#import <Foundation/Foundation.h>
@class SANewDingDanModel;
@interface SANewDingDanListModel : NSObject
@property (nonatomic, strong)NSMutableArray <SANewDingDanModel *>*list;
@end
@interface SANewDingDanModel : NSObject
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, copy)NSString * join_code;
@property (nonatomic, copy)NSString * store_code;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, copy)NSString * ordernum;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, copy)NSString * buying_time;
@property (nonatomic, assign)NSInteger user_id;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * heji;
@property (nonatomic, copy)NSString * amount;
@property (nonatomic, copy)NSString * amount_d;
@property (nonatomic, copy)NSString * hk_date;
@property (nonatomic, copy)NSString * sale;
@property (nonatomic, assign)NSInteger pay_zt;
@property (nonatomic, assign)NSInteger order_type;
@property (nonatomic, copy)NSString * inper;
@property (nonatomic, assign)NSInteger pay_type;
@property (nonatomic, copy)NSString * pay_time;
@property (nonatomic, copy)NSString * insert_time;
@property (nonatomic, copy)NSString * type_name;
@property (nonatomic, copy)NSString * order_type_name;
@property (nonatomic, copy)NSString * saler;
@property (nonatomic, copy)NSString * ID;
@property (nonatomic, assign)NSInteger next_person;
@property (nonatomic ,assign)BOOL isShow;
@property (nonatomic, copy)NSString * user_mobile;
@property (nonatomic, copy) NSString *grade_name;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *jis_acc;


@end
