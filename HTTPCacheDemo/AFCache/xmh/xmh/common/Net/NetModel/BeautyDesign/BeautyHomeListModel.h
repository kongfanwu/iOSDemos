//
//  BeautyHomeListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeautyHomeDModel.h"
#import "BeautyHomeUModel.h"

@interface BeautyHomeListModel : NSObject

@property(nonatomic, assign)long pType;
@property(nonatomic, assign)long total;
@property(nonatomic, assign)long yuangong;
@property(nonatomic, strong)NSMutableArray *dList;
@property(nonatomic, strong)NSMutableArray *uList;

@end
