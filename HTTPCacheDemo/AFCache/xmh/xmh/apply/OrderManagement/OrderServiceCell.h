//
//  OrderServiceCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tempModel.h"
#import "SLGetListModel.h"
#import "SLCooperateModel.h"
#import "SANewDingDanListModel.h"
#import "SATuiKuanListModel.h"
@interface OrderServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *downBgView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn5;

@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UIButton *btnState;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toCeDanConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toZaDanConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (strong, nonatomic) SLDlistModel * listModel;
@property (strong, nonatomic) SANewDingDanModel * saleModel;
@property (strong, nonatomic) SLCooperate * cooperateModel;
@property (strong, nonatomic) SATuiKuanModel * tuiKuanModel;
@property (nonatomic ,assign)NSInteger framework_function_main_role;
- (void)cooperateCardHiddenBtn;

@property (nonatomic ,copy)void(^btn1Click)(SLDlistModel *,NSString *);
@property (nonatomic ,copy)void(^btn2Click)(SLDlistModel *,NSString *);
@property (nonatomic ,copy)void(^btn3Click)(SLDlistModel *,NSString *);
@property (nonatomic ,copy)void(^btn5SaleClick)(SLDlistModel *,NSString *);


@end
