//
//  SLServInfoModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/24.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLInfoPro_List;

@interface SLServInfoModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *stroe_name;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *store_address;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, assign) NSInteger technique;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger xiaohao;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *gk_qz;

@property (nonatomic, copy) NSString *dianzhang;

@property (nonatomic, copy) NSString *z_price;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, copy) NSString *pay_price;

@property (nonatomic, assign) NSInteger belong;

@property (nonatomic, strong) NSArray<SLInfoPro_List *> *pro_list;

@property (nonatomic, copy) NSString *etime;

@property (nonatomic, copy) NSString *inper;

@property (nonatomic, copy) NSString *stime;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *store_tel;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger effect;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger del;

@property (nonatomic, copy) NSString *join_name;

@property (nonatomic, copy) NSString *zt;

@property (nonatomic, assign) NSInteger manner;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, copy) NSString *k_content;

@property (nonatomic, copy) NSString *insert_time;

@end

@interface SLInfoPro_List : NSObject

@property (nonatomic, assign) NSInteger rec_card_id;

@property (nonatomic, copy) NSString *inper;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, assign) NSInteger del;

@property (nonatomic, copy) NSString *join_code;

@property (nonatomic, copy) NSString *ordernum;

@property (nonatomic, assign) NSInteger belong;

@property (nonatomic, copy) NSString *goods_code;

@property (nonatomic, copy) NSString *zt;

@property (nonatomic, assign) NSInteger appo_id;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *insert_time;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *pro_code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *etime;

@property (nonatomic, assign) NSInteger pres_rec_id;

@property (nonatomic, assign) NSInteger pro_rec_id;

@property (nonatomic, assign) NSInteger goods_rec_id;

@property (nonatomic, assign) NSInteger is_end;

@property (nonatomic, copy) NSString *stime;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *jis;

@property (nonatomic, assign) NSInteger xiaohao;

@property (nonatomic, assign) NSInteger course_rec_range_id;

@property (nonatomic, copy) NSString *tai;

@property (nonatomic, copy) NSString *price;

@end


