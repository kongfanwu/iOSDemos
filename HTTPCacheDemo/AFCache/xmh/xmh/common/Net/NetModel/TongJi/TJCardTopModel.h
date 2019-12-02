//
//  TJCardTopModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJCardTopSubModel;
@interface TJCardTopModel : NSObject
@property (nonatomic, strong)NSArray <TJCardTopSubModel *>* list;
@property (nonatomic, copy)NSString * total_num;
@end
@interface TJCardTopSubModel : NSObject
@property (nonatomic, copy)NSString * uid;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * num;
@end
