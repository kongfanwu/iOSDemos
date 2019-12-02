//
//  LApproveCellType2.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  会员冻结申请  H ： 160

#import <UIKit/UIKit.h>
#import "LApproveCommonModel.h"
@interface LApproveCellType2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (strong, nonatomic)LApproveDetailModel * model;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbRead;
@end
