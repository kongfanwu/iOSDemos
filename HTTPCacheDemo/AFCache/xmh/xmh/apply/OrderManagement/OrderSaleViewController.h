//
//  OrderSaleViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SANewDingDanListModel.h"

@interface OrderSaleViewController : UIViewController

@property (nonatomic,assign)BOOL isService;
@property (nonatomic,copy)NSString *cinId;
@property (nonatomic,assign)NSInteger fram_id;
@property (nonatomic,strong)NSString *from;
@property (nonatomic,strong)SANewDingDanModel *Dingdanmodel;

@end
