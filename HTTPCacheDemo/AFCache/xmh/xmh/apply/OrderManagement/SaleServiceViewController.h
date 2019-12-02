//
//  SaleServiceViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"

@interface SaleServiceViewController : UIViewController
@property (nonatomic,assign)NSInteger user_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *store_code;

@property (nonatomic,assign)BOOL isSale;//销售

@property (nonatomic,copy)NSString * yigouNumStr;

@property (nonatomic, strong)NSMutableDictionary *ziHuanDic;

@property (nonatomic,assign)NSInteger billType;//制单的类型 1、服务单 2、销售服务单 3、固定制单 4、已购置换 5、个性制单 6、升卡续卡 7、开始置换
@property (nonatomic, assign)float toPayMoney;//快速开单付款金额
@property (nonatomic, copy) NSString *ordernum;//快速开单订单编号


@end
