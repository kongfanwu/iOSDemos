//
//  BaseModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/29.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface BaseModel : NSObject
@property(nonatomic, assign)NSInteger code;
@property(nonatomic, copy)  NSString *msg;
@property(nonatomic, strong)NSDictionary *data;
@end
