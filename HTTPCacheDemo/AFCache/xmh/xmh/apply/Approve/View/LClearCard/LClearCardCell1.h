//
//  LClearCardCell1.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H : 370

#import <UIKit/UIKit.h>
@class LSponsorApproceModel,LClearCardCell1Model;
@interface LClearCardCell1 : UITableViewCell
/**
 * lb1(金额)lb2(处方金额)lb3(冻结金额) tf1(时间卡余额) tf2(售后服务产品余额) btn(生成总余额按钮)lb4(总余额)tf3(实际退款金额)
 
 */
@property (strong, nonatomic)LSponsorApproceModel * model;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UITextField *tf3;
@property (weak, nonatomic) IBOutlet UITextField *tf4;
@property (copy, nonatomic) void (^LClearCardCell1Block)(LClearCardCell1Model * model);
@end
