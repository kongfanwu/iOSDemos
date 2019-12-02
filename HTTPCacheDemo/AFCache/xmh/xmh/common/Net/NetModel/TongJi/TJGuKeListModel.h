//
//  TJGuKeListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJGuKeClassModel,TJGuKeSubModel;
@interface TJGuKeListModel : NSObject
@property (nonatomic, strong)NSArray <TJGuKeClassModel *>* hydj;
@property (nonatomic, strong)NSArray <TJGuKeSubModel *>* list;
@property (nonatomic, copy)NSString * type;
@end
@interface TJGuKeClassModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * gid;
@property (nonatomic, copy)NSString * count;
@property (nonatomic, copy)NSString * bfb;
@end
@interface TJGuKeSubModel : NSObject
@property (nonatomic, copy)NSString * hdgk;
@property (nonatomic, copy)NSString * yxgk;
@property (nonatomic, copy)NSString * xzgk;
@property (nonatomic, copy)NSString * xmgk;
@property (nonatomic, copy)NSString * lsgk;
@property (nonatomic, copy)NSString * total;
@property (nonatomic, copy)NSString * bfb;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * chanzhi;
@property (nonatomic, copy)NSString * pro_num;
@property (nonatomic, copy)NSString * grade_name;
@property (nonatomic, copy)NSString * headimg;
@property (nonatomic, copy)NSString * store_code;
@property (nonatomic, copy)NSString * uid;
@end
