//
//  MzzXiaoHaoJiLuCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/1/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MzzConsumptionModel;
@interface MzzXiaoHaoJiLuCell : UITableViewCell
/*
 商品名称(1)
 消耗金额(2)
 数字(3)
 项目数(4)
 累计到店(5)
 日期(6)
 */
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (nonatomic ,strong)MzzConsumptionModel *model;
@end
