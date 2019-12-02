//
//  GuDingProOneCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/21.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASaleListModel.h"
#import "SAZhiHuanPorListModel.h"
#import "SADepositListModel.h"
#import "SAAccountModel.h"

@interface GuDingProOneCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UILabel *lb12;
@property (weak, nonatomic) IBOutlet UILabel *lb13;
@property (weak, nonatomic) IBOutlet UILabel *lb14;
@property (weak, nonatomic) IBOutlet UILabel *lb16;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UILabel *lb15;
@property (weak, nonatomic) IBOutlet UIButton *btnReduce;
@property (weak, nonatomic) IBOutlet UIButton *btnCishu;
@property (weak, nonatomic) IBOutlet UIButton *btnZhekou;
@property (weak, nonatomic) IBOutlet UIButton *btnQuan;
@property (weak, nonatomic) IBOutlet UIButton *btnJiangZheng;
@property (weak, nonatomic) IBOutlet UIButton *btnShop;
@property (weak, nonatomic) IBOutlet UIButton *btnQuanBu;

@property (weak, nonatomic) IBOutlet UITextField *textJiaGe;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb5Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb7Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb13Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb14Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb14Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnCiShuCenter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnZheKouTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnQuanTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb12Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *JiaGeLeading;

//项目疗程
- (void)freshGuDingProOneCell:(SaleModel *)model;
@property (nonatomic, copy) void (^btnMoreGuDingBlock)(SaleModel *model);

@property (nonatomic, copy) void (^textJiaGeBlock)(SaleModel *model);

@property (nonatomic, copy) void (^btnShopGDKDBlock)(SaleModel *model);
@property (nonatomic, copy) void (^btnGDKDReduiceAddBlock)(SaleModel *model,NSInteger addflag);

@property (nonatomic, copy) void (^btnCiShuGDKDBlock)();
@property (nonatomic, copy) void (^btnZheKouGDKDBlock)();
@property (nonatomic, copy) void (^btnQuanGDKDBlock)();


//产品
- (void)freshGuDingProChanPinCell:(SaleModel *)model;
//特惠卡
- (void)freshGuDingTeHuiKaCell:(SaleModel *)model;
@property (nonatomic, copy) void (^btnJiangzhengChoiseTeHuiKaBlock)(SaleModel *model);
//任选卡
- (void)freshGuDingRenXuanCell:(SaleModel *)model;
//储值卡
- (void)freshGuDingChuZhiCell:(SaleModel *)model;
//用户自己有储值卡
- (void)freshChuZhiUserCell:(SaleModel *)model;
//时间卡
- (void)freshGuDingshijianCell:(SaleModel *)model;
//票券
- (void)freshGuDingpiaoquanCell:(SaleModel *)model;

//个性制单-项目、产品
- (void)freshGeXingProCell:(SaleModel *)model;
//个性制单-特惠卡
- (void)freshGeXingTeHuiKaCell:(SaleModel *)model;
//个性制单-任选卡
- (void)freshGeXingRenXuanCell:(SaleModel *)model;
//个性制单-时间卡
- (void)freshGeXingShiJianCell:(SaleModel *)model;
//个性制单-票券
- (void)freshGeXingPiaoQuanCell:(SaleModel *)model;

//已购置换-项目
- (void)freshYiGouZhiHuanProOneCell:(SAZhiHuanPorModel *)model QuanBuState:(BOOL)state;
@property (nonatomic, copy) void (^btnMoreYiGouZhiHuanBlock)(SAZhiHuanPorModel *model);
@property (nonatomic, copy) void (^btnYGZHReduiceAddBlock)(SAZhiHuanPorModel *model,NSInteger addflag);
@property (nonatomic, copy) void (^btnShopYiGouZhiHuanBlock)(SAZhiHuanPorModel *model);
@property (nonatomic, copy) void (^btnQauanBuYiGouZhiHuanBlock)(SAZhiHuanPorModel *model);

//已购置换-定金订单
- (void)freshYiGouZhiHuanDingJinDingDanCell:(SADepositListModelSales *)model;
@property (nonatomic, copy) void (^btnMoreYiGouZhiHuanDingJinBlock)(SADepositListModelSales *model);
@property (nonatomic, copy) void (^btnYGZHReduiceAddDingJinBlock)(SADepositListModelSales *model,NSInteger addflag);
@property (nonatomic, copy) void (^btnShopDingJinBlock)(SADepositListModelSales *model);

//开始置换 账户
- (void)freshKSZHUserProOneCell:(SAAccountModel *)model userName:(NSString *)name;
@property (nonatomic, copy) void (^btnShopKSZHUserBlock)(SAAccountModel *model);

@end
