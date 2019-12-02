//
//  BeautySubCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiaoChengXiangMuModel.h"
#import "LiaoChengXiangMuInfo.h"
#import "BeautyCardModel.h"
@interface BeautySubCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UILabel *lb10;

//增加
@property (copy, nonatomic) void (^BeautySubCellAddBlock)(LiaoChengXiangMuModel*model);
//减少
@property (copy, nonatomic) void (^BeautySubCellReduceBlock)(LiaoChengXiangMuModel*model);
/**
 *刷新BeautySubCell
 */
- (void)reFreshBeautySubCell:(LiaoChengXiangMuModel*)model;

//增加
@property (copy, nonatomic) void (^BeautySubCellCardAddBlock)(BeautyCardRange*model);
//减少
@property (copy, nonatomic) void (^BeautySubCellCardReduceBlock)(BeautyCardRange*model);

- (void)reFreshBeautySubCell1:(BeautyCardRange *)model;

@end
