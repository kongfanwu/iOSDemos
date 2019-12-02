//
//  ShengKaXuKaCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/29.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASaleListModel.h"
#import "ShengKaXuKaRenXuanKa.h"
#import "ShengKaXuKaShiJianModel.h"
#import "ShengKaXuKaChuZhiModel.h"
#import "SAZhiHuanPorListModel.h"

#import "SKXKProOneceModel.h"
#import "ShengKaXuKaProModel.h"
#import "ShengKaXuKaKeShengHuiYuanKa.h"

@interface ShengKaXuKaCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UIButton *btnMuBiao;



@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UILabel *lb12;

@property (weak, nonatomic) IBOutlet UILabel *lb15;
@property (weak, nonatomic) IBOutlet UILabel *lb16;
@property (weak, nonatomic) IBOutlet UILabel *lb17;
@property (weak, nonatomic) IBOutlet UILabel *lb18;

@property (weak, nonatomic) IBOutlet UILabel *lb9;

@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;

@property (weak, nonatomic) IBOutlet UILabel *lb10;
@property (weak, nonatomic) IBOutlet UITextField *textJinE;
@property (weak, nonatomic) IBOutlet UIButton *btnShop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint*lb6Top;
@property (weak, nonatomic) IBOutlet UILabel *lb19;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;
@property (weak, nonatomic) IBOutlet UILabel *lb20;
@property (weak, nonatomic) IBOutlet UILabel *lb21;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb5Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb9Top;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbnum;
@property (weak, nonatomic) IBOutlet UIButton *btnReduce;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb10Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnAddTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn7Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toJzConstraint;

@property (nonatomic, copy) void (^btnShopShengKaXuKaCellBlock)(NSString *ids,NSString *to_code,NSString *save_old,NSString *to_type,NSString *up_type,NSString *price,SKXKProOneceModel *model);

//项目疗程卡
- (void)freshShengKaXuKaProCell:(SKXKProOneceModel *)model;
//时间卡
- (void)freshShengKaXuKashijianCell:(ShengKaXuKaShiJianList *)model;
@property (nonatomic, copy) void (^btnMoreTimeEventBlock)(ShengKaXuKaShiJianList *model);
@property (nonatomic, copy) void (^btnTimemubiaoBlock)(ShengKaXuKaShiJianList *model);
@property (nonatomic, copy) void (^btnShopShengKaXuKaTimeCellBlock)(NSString *ids,NSString *to_code,NSString *award_del,NSString *save_old,NSString *to_type,NSString *up_type,NSString *price,NSString *name,NSString *numDisPlay,ShengKaXuKaShiJianList *model);
//任选卡
- (void)freshShengKaXuKaRenXuanCell:(ShengKaXuKaRenXuanData *)model;
@property (nonatomic, copy) void (^btnMoreCardnumEventBlock)(ShengKaXuKaRenXuanData *model);
@property (nonatomic, copy) void (^btnRenXuanmubiaoBlock)(ShengKaXuKaRenXuanData *model);

@property (nonatomic, copy) void (^btnShopShengKaXuKaCardNumCellBlock)(NSString *ids,NSString *to_code,NSString *award_del,NSString *save_old,NSString *to_type,NSString *up_type,NSString *price,NSString *name,NSString *numDisPlay,ShengKaXuKaRenXuanData *model);

//储值卡
- (void)freshShengKaXuKaChuZhiCell:(ShengKaChuZhiList *)model;
@property (nonatomic, copy) void (^btnMoreStoreEventBlock)(ShengKaChuZhiList *model);
@property (nonatomic, copy) void (^btnShopShengKaXuKaStoreCardCellBlock)(NSString *ids,NSString *to_code,NSString *award_del,NSString *save_old,NSString *to_type,NSString *up_type,NSString *price,NSString *name,NSString *numDisPlay,ShengKaChuZhiList *model);

@property (nonatomic, copy) void (^btnSKXKStore_cardSXEventBlock)(ShengKaChuZhiList *model,NSInteger btnChoice);
@property (nonatomic, copy) void (^btnStoremubiaoBlock)(ShengKaChuZhiList *model);
//已购置换-时间卡
- (void)freshYiGouZhiHuanTime:(SAZhiHuanPorModel *)model;
@property (nonatomic, copy) void (^btnMoreYiGouZhiHuanTimeBlock)(SAZhiHuanPorModel *model);
@property (nonatomic, copy) void (^btnYGZHReduiceAddTimeBlock)(SAZhiHuanPorModel *model,NSInteger addFlag);
@property (nonatomic, copy) void (^btnShopYiGouZhiHuanTimeBlock)(SAZhiHuanPorModel *model);
//已购置换-票券
- (void)freshYiGouZhiHuanPiaoQuan:(SAZhiHuanPorModel *)model;
@end
