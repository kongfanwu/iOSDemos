//
//  LOrderDetailCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/5/2.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
// 配合消费  退款金额   销售业绩 三个公用cell

#import <UIKit/UIKit.h>
#import "SLGetListModel.h"
#import "SLCooperateModel.h"
#import "SANewDingDanListModel.h"
#import "SATuiKuanListModel.h"
#import "tempModel.h"
#import "LOrderYejiListModel.h"
@interface LOrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbCode;
@property (weak, nonatomic) IBOutlet UILabel *lbState;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic)SATuiKuanModel * tuiKuanModel;
@property (strong, nonatomic)SLCooperate * cooperateModel;
@property (strong, nonatomic)SLCooperate * haokacooperateModel;
@property (strong, nonatomic)LOrderYejiModel * yejiModel;
- (void)refreshLOrderDetailCell:(tempModel*)model;
@end
