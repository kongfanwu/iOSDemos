//
//  BeautGouWuCheCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyProjectModel.h"
@interface BeautGouWuCheCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIImageView *line;

//增加
@property (copy, nonatomic) void (^BeautGouWuCheCellAddBlock)(BeautyProjectModel*model);
//减少
@property (copy, nonatomic) void (^BeautGouWuCheCellReduceBlock)(BeautyProjectModel*model);

- (void)reFreshBeautGouWuCheCell:(BeautyProjectModel *)model;

@end
