//
//  SerViceRightCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/12.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLServAppoModel.h"
#import "SLPresModel.h"
#import "SLGoodsModel.h"
#import "SLServPro.h"
#import "SLTi_CardModel.h"
#import "TiCardTypeDefine.h"

@interface SerViceRightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;

//预约服务
- (void)freshSerViceRightCellPro:(SLAppo_Pro *)model;
- (void)freshSerViceRightCellPres:(SLPro *)model;
@property (nonatomic, copy) void (^btnSerViceRightCellSLAppo_ProBlock)(SLAppo_Pro *model, NSInteger indexAdd);//1减，2加
@property (nonatomic, copy) void (^btnSerViceRightCellSLProBlock)(SLPro *model, NSInteger indexAdd);//1减，2加

//处方服务
- (void)freshSerViceRightCellPro_List:(Pro_List *)model;
@property (nonatomic, copy) void (^btnSerViceRightCellPro_ListBlock)(Pro_List *model, NSInteger indexAdd);//1减，2加

//项目服务
- (void)freshSerViceRightCellSLProModel:(SLProModel *)model;
@property (nonatomic, copy) void (^btnSerViceRightCellSLProModelBlock)(SLProModel *model, NSInteger indexAdd);//1减，2加

//产品服务
- (void)freshSerViceRightCellSLGood:(SLGood *)model;
@property (nonatomic, copy) void (^btnSerViceRightCellSLGoodBlock)(SLGood *model, NSInteger indexAdd);//1减，2加

//提卡-项目
- (void)freshSerViceRightCellSLPro_List:(SLPro_List *)model Id:(NSInteger)ID Type:(TiCardType)type Whice:(NSInteger)whice;
@property (nonatomic, copy) void (^btnSerViceRightCellSLPro_ListdBlock)(NSInteger ID, SLPro_List *model,TiCardType type,NSInteger whice, NSInteger indexAdd);//1减，2加

//提卡-产品
- (void)freshSerViceRightCellSLGoods_List:(SLGoods_List *)model Id:(NSInteger)ID Type:(TiCardType)type Whice:(NSInteger)whice;
@property (nonatomic, copy) void (^btnSerViceRightCellSLGoods_ListBlock)(NSInteger ID, SLGoods_List *model,TiCardType type,NSInteger whice, NSInteger indexAdd);//1减，2加

@end
