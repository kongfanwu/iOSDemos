//
//  SACourseModeList.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SACourseMode,SARangeModel;
@interface SACourseModeList : NSObject
@property (nonatomic, strong)NSArray <SACourseMode *>*list;
@end

@interface SACourseMode : NSObject
@property (nonatomic, assign)NSInteger group_id;
@property (nonatomic, assign)NSInteger group_map;
@property (nonatomic, strong)NSArray <SARangeModel *>*range;
@end

@interface SARangeModel : NSObject
@property (nonatomic, assign)NSInteger rights;
@property (nonatomic, assign)NSInteger main;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, assign)NSInteger fixed;
@property (nonatomic, assign)NSInteger group_id;
@property (nonatomic, assign)NSInteger group_map;
@end
