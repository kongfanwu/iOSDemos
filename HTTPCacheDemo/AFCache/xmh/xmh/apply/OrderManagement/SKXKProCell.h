//
//  SKXKProCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShengKaXuKaProModel.h"
#import "ShengKaXuKaKeShengHuiYuanKa.h"
#import "CiShuModel.h"
#import "SATicketListModel.h"
#import "ZheKouModel.h"
@interface SKXKProCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lb11Top;

@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UILabel *lb12;

- (void)freshSKXKProCell:(ShengKaXuKaProDataList *)model;
@property (nonatomic, copy) void (^btnSKXKProCellBlock)(ShengKaXuKaProDataList *model);

- (void)freshSKXKMuBiaoCell:(ShengKaXuKaKeShengHuiYuanKaList *)model;
@property (nonatomic, copy) void (^btnSKXKMuBiaoCellBlock)(ShengKaXuKaKeShengHuiYuanKaList *model);

- (void)freshSKXKZheKouCell:(ZheKouStored_Card *)model;
@property (nonatomic, copy) void (^btnSKXKZheKouCellBlock)(ZheKouStored_Card *model);

- (void)freshSKXKCiShuCell:(CiShuModel *)cishumodel;
@property (nonatomic, copy) void (^btnSKXKCiShuCellBlock)(CiShuModel *model);

- (void)freshSKXKDiYongQuanCell:(SATicketModel *)model;
@property (nonatomic, copy) void (^btnSKXKDiYongQuanCellBlock)(SATicketModel *model);

@end
