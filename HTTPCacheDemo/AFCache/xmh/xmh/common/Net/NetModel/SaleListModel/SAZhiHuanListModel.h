//
//  SAZhiHuanListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/2.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SAZhiHuanAwardModel,SAZhiHuanRangeModel;
@interface SAZhiHuanListModel : NSObject
@property (nonatomic, strong)NSArray<SAZhiHuanAwardModel *> * award;
@property (nonatomic, assign)NSInteger qiankuan;
@property (nonatomic, assign)NSInteger order_type;
@property (nonatomic, strong)NSArray<SAZhiHuanAwardModel *> * y_award;
@end

@interface SAZhiHuanAwardModel : NSObject
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger price;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, assign)NSInteger user_id;
@property (nonatomic, assign)NSInteger sales_id;
@property (nonatomic, strong)NSArray<SAZhiHuanRangeModel *> * range;
@end


@interface SAZhiHuanRangeModel : NSObject
@property (nonatomic, assign)NSInteger group_id;
@property (nonatomic, assign)NSInteger group_price;
@property (nonatomic, copy)NSString * group_map;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, copy)NSString * num;
@end
