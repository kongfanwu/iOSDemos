//
//  LOrderYejiListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/2.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LOrderYejiModel;
@interface LOrderYejiListModel : NSObject
@property (nonatomic, strong)NSArray <LOrderYejiModel *>* list;
@property (nonatomic, copy)NSString * sales_amount;
@property (nonatomic, assign)NSInteger sales_num;
@end

@interface LOrderYejiModel : NSObject
@property (nonatomic, copy)NSString * ordernum;
@property (nonatomic, assign)NSInteger user_id;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, copy)NSString * inper;
@property (nonatomic, copy)NSString * type_name;
@property (nonatomic, copy)NSString * insert_time;
@property (nonatomic, copy)NSString * zt;
@property (nonatomic, copy)NSString * order_type_name;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * user_mobile;
@property (nonatomic, copy)NSString * saler;
@property (nonatomic, copy)NSString * amount;

@end
