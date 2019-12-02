//
//  CustomerBillConfirmViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"

@class CustomerBillConfirmViewController;

@protocol CustomerBillConfirmViewControllerDelegate <NSObject>//协议

- (void)getBillDicDelgateMethod:(NSMutableDictionary *)dic;

@end


@interface CustomerBillConfirmViewController : UIViewController
@property (nonatomic, assign) id<CustomerBillConfirmViewControllerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic,strong)NSMutableDictionary *dic;

@property (strong, nonatomic)CustomerModel * customerModel;

@property (nonatomic, copy) void (^popBlock)(BOOL isModify,NSMutableDictionary *dic,NSInteger section,CustomerModel * customerModel);

@property (nonatomic, copy) void (^delBlock)(NSMutableDictionary *dic, NSInteger section);

/** 是否是新版的顾客管理 */
@property (nonatomic, assign)BOOL isNewGKGL;
@end
