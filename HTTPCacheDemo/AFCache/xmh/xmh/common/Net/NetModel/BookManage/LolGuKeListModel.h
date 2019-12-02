//
//  LolGuKeListModel.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@class LolHomeGuKeModel;
@interface LolGuKeListModel : NSObject
@property (strong ,nonatomic)NSMutableArray<LolHomeGuKeModel *> * list;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, assign)NSInteger serv_num;
@property (nonatomic, assign)NSInteger pro_num;
@property (nonatomic, assign)NSInteger standard;
@property (nonatomic, strong)NSString * probability;
@property (nonatomic, strong)NSString * date;
@property (nonatomic, assign)BOOL isShow;
@end
