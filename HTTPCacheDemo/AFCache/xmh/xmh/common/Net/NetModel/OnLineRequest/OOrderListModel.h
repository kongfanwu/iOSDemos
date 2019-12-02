//
//  OOrderListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/3.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OOrderModel;
@interface OOrderListModel : NSObject
@property (nonatomic, strong)NSArray <OOrderModel *>* list;
@end

@interface OOrderModel : NSObject
@property (nonatomic, copy)NSString * ordernum;
@property (nonatomic, copy)NSString * create;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * num;
@property (nonatomic, copy)NSString * pay_type;
@property (nonatomic, copy)NSString * dc;
@property (nonatomic, copy)NSString * express;
@property (nonatomic, copy)NSString * expnum;
@property (nonatomic, copy)NSString * user_name;
@property (nonatomic, copy)NSString * mobile;
@property (nonatomic, copy)NSString * pro_ly;
@property (nonatomic, copy)NSString * amount;
@property (nonatomic, copy)NSString * type;
@end
