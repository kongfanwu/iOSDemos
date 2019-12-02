//
//  MzzGuDingZhiDanController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MzzGuDingZhiDanController : BaseViewController
@property (nonatomic,assign)NSInteger user_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, strong) NSMutableDictionary *commitDic;
@property (nonatomic,copy)NSString *store_code;

@property (nonatomic,assign)float toPayMoney;
@property (nonatomic, copy) NSString *ordernum;//快速开单订单编号



@end
