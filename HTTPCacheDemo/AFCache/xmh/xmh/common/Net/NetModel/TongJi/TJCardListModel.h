//
//  TJCardListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJCardModel;
@interface TJCardListModel : NSObject
@property (nonatomic, strong)NSArray <TJCardModel *>* list;
@property (nonatomic, copy)NSString * total_renshu;
@property (nonatomic, copy)NSString * total_cishu;
@property (nonatomic, copy)NSString * total_money;
@property (nonatomic, copy)NSString * total_bfb;
@end
@interface TJCardModel : NSObject
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * renshu;
@property (nonatomic, copy)NSString * cishu;
@property (nonatomic, copy)NSString * money;
@property (nonatomic, copy)NSString * bfb;
@property (nonatomic, copy)NSString * sort;
@end
