//
//  TJYeJiListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJYeJiDataModel;
@interface TJYeJiListModel : NSObject
@property (nonatomic, strong)NSArray <TJYeJiDataModel *>* list;
@end
@interface TJYeJiDataModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * people_num;
@property (nonatomic, copy)NSString * pro_num;
@property (nonatomic, copy)NSString * amount;
@property (nonatomic, copy)NSString * bfb;
@property (nonatomic, copy)NSString * sort;
@end
