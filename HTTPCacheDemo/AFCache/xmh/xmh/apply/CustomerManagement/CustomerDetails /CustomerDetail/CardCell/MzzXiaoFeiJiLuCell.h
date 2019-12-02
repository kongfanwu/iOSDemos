//
//  MzzXiaoFeiJiLuCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  H 126

#import <UIKit/UIKit.h>
@class MzzConsumption_salesModel;
@interface MzzXiaoFeiJiLuCell : UITableViewCell
/*
 编码(1)
 商品名称(2)
 金额/累计(3)
 间隔/天(4)
 日期(5)
 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (nonatomic ,strong)MzzConsumption_salesModel *model;
@end
