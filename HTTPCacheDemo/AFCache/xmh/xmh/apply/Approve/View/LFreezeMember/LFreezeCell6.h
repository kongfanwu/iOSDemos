//
//  LFreezeCell6.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 35

#import <UIKit/UIKit.h>
#import "LSponsorApproceModel.h"
#import "SPGetTdPersonModel.h"
@interface LFreezeCell6 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (strong, nonatomic)LApprocePersonModel * model;
@property (strong, nonatomic)SPPersonModel * pmodel;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@end
