//
//  LolGuKeStateModelList.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LolGuKeStateModel;
@interface LolGuKeStateModelList : NSObject
@property (copy, nonatomic)NSString * icon;
@property (copy, nonatomic)NSString * user_name;
@property (strong, nonatomic)NSArray <LolGuKeStateModel *>* list;
@end

@interface LolGuKeStateModel : NSObject
@property (copy, nonatomic)NSString * pro;
@property (copy, nonatomic)NSString * state;
@property (copy, nonatomic)NSString * date;
@property (copy, nonatomic)NSString * ordernum;
@property (copy, nonatomic)NSString * to_gd;
@end
