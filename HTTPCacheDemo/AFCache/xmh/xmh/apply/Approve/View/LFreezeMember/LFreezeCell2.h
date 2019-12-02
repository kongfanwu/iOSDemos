//
//  LFreezeCell2.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H： 185

#import <UIKit/UIKit.h>
@class LSponsorApproceModel;
@interface LFreezeCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (strong, nonatomic)LSponsorApproceModel * model;
@end
