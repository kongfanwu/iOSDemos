//
//  TJGuKeShouHouCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 95

#import <UIKit/UIKit.h>
#import "TJGuKeListModel.h"
@interface TJGuKeShouHouCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic)TJGuKeSubModel * model;
@end
