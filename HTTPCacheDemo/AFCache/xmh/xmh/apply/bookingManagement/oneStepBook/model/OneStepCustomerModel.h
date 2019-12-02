//
//  OneStepCustomerModel.h
//  xmh
//
//  Created by 李晓明 on 2017/12/2.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneStepCustomerModel : NSObject
@property (nonatomic, copy)NSString * icon;                     //头像
@property (nonatomic, copy)NSString * store;                    //所属门店
@property (nonatomic, copy)NSString * name;                     //顾客姓名
@property (nonatomic, copy)NSString * memberClass;              //会员等级
@property (nonatomic, copy)NSString * phoneNum;                 //电话话码
@end
