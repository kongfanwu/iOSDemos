//
//  CustomerBookProjectModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerBookProjectModel : NSObject
//服务时长
@property (nonatomic, assign)NSInteger  max_time;
//服务时间
@property (nonatomic, copy)NSString * appo_data;
//服务项目
@property (nonatomic, copy)NSString * pro_list;
//备注
@property (nonatomic, copy)NSString * content;
@end
