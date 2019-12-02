//
//  SASalesInfoModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SASalesDataModel,SASaleModel,SADataModel,SAListModel,SAGoodsModel,SASubGoodModel,SAProModel,SASubCardCourseModel,SASubCardNumModel,SASubStoreCardModel,SASubCardTimeModel,SASubTicketModel,SACardCourseModel,SACardNumModel,SAStoreCardModel,SACardTimeModel,SATicketModel,SASubModel;
@interface SASalesInfoModel : NSObject
@property (nonatomic, assign)NSInteger sales_id;
@property (nonatomic, copy)NSString * sales_tel;
@property (nonatomic, copy)NSString * join_name;
@property (nonatomic, copy)NSString * store_name;
@property (nonatomic, copy)NSString * store_address;
@property (nonatomic, copy)NSString * ordernum;
@property (nonatomic, copy)NSString * buying_time;
@property (nonatomic, assign)NSInteger user_id;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * user_mobile;
@property (nonatomic, copy)NSString * inper;
@property (nonatomic, copy)NSString * insert_time;
@property (nonatomic, copy)NSString * yeji;
@property (nonatomic, assign)NSInteger is_fq;
@property (nonatomic, copy)NSString * heji;
@property (nonatomic, copy)NSString * amount;
@property (nonatomic, assign)NSInteger dianzhang;
@property (nonatomic, strong)NSArray <SASaleModel *>*sale;
@property (nonatomic, assign)NSInteger order_type;
@property (nonatomic, copy)NSString * order_type_name;
@property (nonatomic, assign)NSInteger action;
@property (nonatomic, copy)NSString * sales_sign;
@property (nonatomic, strong)SADataModel * data;
//@property (nonatomic, strong)SASaleModel * data;
@end


//@interface SASalesDataModel : NSObject
//@property (nonatomic, assign)NSInteger sales_id;
//@property (nonatomic, copy)NSString * sales_tel;
//@property (nonatomic, copy)NSString * join_name;
//@property (nonatomic, copy)NSString * store_name;
//@property (nonatomic, copy)NSString * store_address;
//@property (nonatomic, copy)NSString * ordernum;
//@property (nonatomic, copy)NSString * buying_time;
//@property (nonatomic, assign)NSInteger user_id;
//@property (nonatomic, copy)NSString * user_name;
//@property (nonatomic, copy)NSString * user_mobile;
//@property (nonatomic, copy)NSString * inper;
//@property (nonatomic, copy)NSString * insert_time;
//@property (nonatomic, copy)NSString * yeji;
//@property (nonatomic, assign)NSInteger is_fq;
//@property (nonatomic, copy)NSString * heji;
//@property (nonatomic, copy)NSString * amount;
//@property (nonatomic, assign)NSInteger dianzhang;
//@property (nonatomic, strong)NSArray <SASaleModel *>*sale;
//@property (nonatomic, assign)NSInteger order_type;
//@property (nonatomic, copy)NSString * order_type_name;
//@property (nonatomic, assign)NSInteger action;
//@property (nonatomic, copy)NSString * sales_sign;
//@property (nonatomic, strong)SADataModel * data;
//@end

@interface SASaleModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, assign)NSInteger value;
@end
@interface SADataModel : NSObject
@property (nonatomic, strong)SAProModel * pro;
@property (nonatomic, strong)SAGoodsModel * goods;
@property (nonatomic, strong)SACardCourseModel * card_course;
@property (nonatomic, strong)SACardNumModel * card_num;
@property (nonatomic, strong)SAStoreCardModel * stored_card;
@property (nonatomic, strong)SACardTimeModel * card_time;
@property (nonatomic, strong)SATicketModel * ticeket;
@property (nonatomic, copy)NSString * award;
@end
@interface SAProModel : NSObject
@property (nonatomic, strong)NSArray <SASubModel *>* list;
@end
@interface SASubModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, assign)NSInteger pro_num;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, copy)NSString * prcie;
@property (nonatomic, assign)NSInteger pro_type;
@end
@interface SAGoodsModel : NSObject
@property (nonatomic, strong)NSArray <SASubGoodModel *>* list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger zongjia;
@end
@interface SASubGoodModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, assign)NSInteger num;
@end

@interface SACardCourseModel : NSObject
@property (nonatomic, strong)NSArray <SASubCardCourseModel *>* list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger zongjia;
@end
@interface SASubCardCourseModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, assign)NSInteger num;
@end

@interface SACardNumModel : NSObject
@property (nonatomic, strong)NSArray <SASubCardNumModel *>* list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger zongjia;
@end
@interface SASubCardNumModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, copy)NSString * pay_name;
@end

@interface SALStoreCardModel : NSObject
@property (nonatomic, strong)NSArray <SASubStoreCardModel *>* list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger zongjia;
@end
@interface SASubStoreCardModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, assign)NSInteger num;
@end

@interface SACardTimeModel : NSObject
@property (nonatomic, strong)NSArray <SASubCardTimeModel *>* list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger zongjia;
@end
@interface SASubCardTimeModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, assign)NSInteger num;
@end

@interface SALTicketModel : NSObject
@property (nonatomic, strong)NSArray <SASubTicketModel *>* list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger zongjia;
@end
@interface SASubTicketModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, assign)NSInteger num;
@end

