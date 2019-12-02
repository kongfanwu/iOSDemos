//
//  LApproveCellType5.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  添加顾客申请 H : 140

#import <UIKit/UIKit.h>
#import "LApproveCommonModel.h"
@interface LApproveCellType5 : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgV;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lb1;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lb2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lb3;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lb4;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lb5;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lb6;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lbRead;
@property (strong, nonatomic)LApproveDetailModel * model;
@end
