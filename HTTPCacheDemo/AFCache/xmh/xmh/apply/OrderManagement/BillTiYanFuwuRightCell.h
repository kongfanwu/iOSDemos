//
//  BillTiYanFuwuRightCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLS_ProModel.h"
#import "SLGoodListModel.h"
#import "SLSCourseExper.h"

@interface BillTiYanFuwuRightCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UIButton *btnShopAdd;

@property (weak, nonatomic) IBOutlet UILabel *lb12;
@property (weak, nonatomic) IBOutlet UIButton *btnQuan;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle12;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopConstraint;

//项目
- (void)freshBillTiYanFuwuRightCell1:(SLS_Pro *)model;
/**
 *项目
 */
@property (nonatomic, copy) void (^btnBillTiYanFuwuRightCellSLS_ProBlock)(SLS_Pro *model, NSInteger indexAdd);//1减，2加
//产品
- (void)freshBillTiYanFuwuRightCell2:(SLGoodModel *)model;
/**
 *产品
 */
@property (nonatomic, copy) void (^btnBillTiYanFuwuRightCellSLGoodModelBlock)(SLGoodModel *model, NSInteger indexAdd);//1减，2加

//体验-项目
- (void)freshBillTiYanFuwuRightCell3:(SLPro_ListM *)model;
/**
 *体验-项目
 */
@property (nonatomic, copy) void (^btnBillTiYanFuwuRightCellSLPro_ListMBlock)(SLPro_ListM *model, NSInteger indexAdd);//1减，2加
//体验-产品
- (void)freshBillTiYanFuwuRightCell4:(SLGoods_ListM *)model;
/**
 *体验-产品
 */
@property (nonatomic, copy) void (^btnBillTiYanFuwuRightCellSLGoods_ListMBlock)(SLGoods_ListM *model, NSInteger indexAdd);//1减，2加
@property (nonatomic, copy) void (^btnQuanGDKDBlock)();
@property (nonatomic, copy) void (^btnShopGDKDBlock)(SLS_Pro *model);

@end
