//
//  choiceCustomerSubInfo.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface choiceCustomerSubInfo : NSObject
@property(nonatomic, copy)NSString *account;
@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, copy)NSString *insert_time;
@property(nonatomic, copy)NSString *user_headimgurl;
@property(nonatomic, copy)NSString *store_code;
@property(nonatomic, assign)long grade;
@property(nonatomic, assign)long user_id;
@property(nonatomic, copy)NSString *user_name;
@property(nonatomic, copy)NSString *store_name;
@property(nonatomic, copy)NSString *jis_name;
@property(nonatomic, copy)NSString *jis;
@property(nonatomic, assign)BOOL seleted;

@end
