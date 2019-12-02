//
//  LolYuanGongSubCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/19.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 105

#import <UIKit/UIKit.h>
#import "LolMarkView.h"
@class LolHomeModel;
@interface LolDianZhangCellSubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet LolMarkView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (strong,  nonatomic) LolHomeModel * model;
@end
