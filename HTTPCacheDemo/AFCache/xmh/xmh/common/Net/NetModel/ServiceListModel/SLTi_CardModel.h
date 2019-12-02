//
//  SLTi_CardModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLStored_Card,SLPro_List,SLGoods_List,SLCard_Num,SLCard_Time;

@interface SLTi_CardModel : NSObject

@property (nonatomic,assign)BOOL isShow;

@property (nonatomic, strong) NSArray<SLStored_Card *> *stored_card;

@property (nonatomic, strong) NSArray<SLCard_Num *> *card_num;

@property (nonatomic, strong) NSArray<SLCard_Time *> *card_time;

@end

@interface SLStored_Card : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *stored_code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<SLPro_List *> *pro_list;

@property (nonatomic, strong) NSArray<SLGoods_List *> *goods_list;

@end

@interface SLPro_List : NSObject

@property (nonatomic, copy) NSString *pro_code;

@property (nonatomic, copy) NSString *diffid;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, assign) NSInteger numDisplay;


@end

@interface SLGoods_List : NSObject

@property (nonatomic, copy) NSString *goods_code;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, assign) NSInteger numDisplay;

@end

@interface SLCard_Num : NSObject

@property (nonatomic, strong) NSArray<SLPro_List *> *pro_list;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) NSArray<SLGoods_List *> *goods_list;

@property (nonatomic, copy) NSString *card_num_code;

@property (nonatomic, copy) NSString *name;

@end

@interface SLCard_Time : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *card_time_code;

@property (nonatomic, strong) NSArray<SLPro_List *> *pro_list;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<SLGoods_List *> *goods_list;

@end



