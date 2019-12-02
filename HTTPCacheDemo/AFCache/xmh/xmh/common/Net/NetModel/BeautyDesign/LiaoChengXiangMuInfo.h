//
//  LiaoChengXiangMuInfo.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LiaoChengXiangMuInfo : NSObject
@property(nonatomic, copy)NSString *unit;
@property(nonatomic, copy)NSString *store_codes;
@property(nonatomic, copy)NSString *code;
@property(nonatomic, assign)long uid;
@property(nonatomic, assign)long limit;
@property(nonatomic, assign)long shichang;
@property(nonatomic, copy)NSString *name;
@property (nonatomic, assign) NSInteger price;
@property(nonatomic, assign)long state;

@end
