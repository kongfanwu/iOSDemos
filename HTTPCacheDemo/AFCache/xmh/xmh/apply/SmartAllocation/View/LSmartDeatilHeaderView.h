//
//  LSmartDeatilHeaderView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/9.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
// H : 205

#import <UIKit/UIKit.h>
#import "LAllocationDetaiModel.h"
@interface LSmartDeatilHeaderView : UIView
@property (nonatomic, strong)LAllocationDetaiModel * model;
@property (nonatomic, strong)LAllocationListModel * listModel;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UILabel *lbName1;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UILabel *lbName2;
@property (weak, nonatomic) IBOutlet UILabel *lbr1;
@property (weak, nonatomic) IBOutlet UILabel *lbr2;
@property (weak, nonatomic) IBOutlet UILabel *lbr3;
@property (weak, nonatomic) IBOutlet UILabel *lbr4;
@property (weak, nonatomic) IBOutlet UILabel *lbr5;
@property (weak, nonatomic) IBOutlet UILabel *lbr6;
@property (weak, nonatomic) IBOutlet UILabel *lbr7;
@end
