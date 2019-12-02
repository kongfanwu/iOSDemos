//
//  BeautyProjectModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/22.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface BeautyProjectModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *card_num_code;

@property (nonatomic, assign) NSInteger rights;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger numTotal;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger shichang;

@property (nonatomic, assign) BOOL pro;//是项目
@property (nonatomic, assign) BOOL time;//是时间卡
@property (nonatomic, assign) BOOL stored;//是储值卡
@property (nonatomic, assign) BOOL numType;//是任选卡

@property (nonatomic, copy) NSString *ordernum;


@property (nonatomic, assign) NSInteger outsideID;
@property (nonatomic, assign) NSInteger insideID;


@end
