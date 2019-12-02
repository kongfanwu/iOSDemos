//
//  SAFuWuXiaoShouListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/1.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SAFuWuXiaoShouListSubModel;
@interface SAFuWuXiaoShouListModel : NSObject
@property (nonatomic, assign)NSInteger pType;
@property (nonatomic, strong)NSArray <SAFuWuXiaoShouListSubModel *>* dList;
@end

@interface SAFuWuXiaoShouListSubModel : NSObject
@property (nonatomic, assign)NSInteger uid;
@property (nonatomic, copy)NSString * ordernum;
@property (nonatomic, copy)NSString * zt;
@property (nonatomic, copy)NSString * inper;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, copy)NSString * stime;
@property (nonatomic, assign)NSInteger user_id;
@property (nonatomic, copy)NSString * etime;
@property (nonatomic, copy)NSString * za_name;
@property (nonatomic, copy)NSString * type_name;
@property (nonatomic, copy)NSString * inper_name;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * mobile;
@property (nonatomic, strong)NSArray * pro_list;
@property (nonatomic, strong)NSArray * goods_list;
@end
