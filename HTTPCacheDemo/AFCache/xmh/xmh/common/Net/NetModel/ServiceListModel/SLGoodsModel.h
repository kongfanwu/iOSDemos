//
//  SLGoodsModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLGood;

@interface SLGoodsModel : NSObject

@property (nonatomic, strong) NSArray<SLGood *> *list;

@end

@interface SLGood : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *goods_code;

@property (nonatomic, assign) NSInteger s_num;

@property (nonatomic, assign) NSInteger numDisplay;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger shichang;
@property (nonatomic, copy) NSString *diffid;

@end


