//
//  CustomerBillViewController.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/22.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerListModel.h"
#import "BeautyDesignDownView.h"
@interface CustomerBillViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UITableView *tbView1;
@property (weak, nonatomic) IBOutlet UIScrollView *rightScroll;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *lbLeft;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;

@property (strong, nonatomic) UIButton    *btnGouWuChe;
@property (strong, nonatomic) UILabel *lbNum;

@property (strong, nonatomic) UIButton    *btnNext;

@property (strong, nonatomic)CustomerModel * customerModel;
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,strong)NSString *store_codeByPass;
@property (assign, nonatomic)BOOL  isModify;
@property (nonatomic,strong)NSMutableDictionary *dicModify;
@property (assign, nonatomic)NSInteger sectionModify;
/** 是否是新版的顾客管理 */
@property (nonatomic, assign)BOOL isNewGKGL;
@property (nonatomic, copy) void (^btnCustomerBillViewControllerModifyBlock)(NSMutableDictionary *dic, NSInteger section);


@end
