//
//  TJXiaoHaoCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/27.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJYeJiListModel.h"
@interface TJXiaoHaoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (nonatomic, strong)TJYeJiDataModel * model;
@end
