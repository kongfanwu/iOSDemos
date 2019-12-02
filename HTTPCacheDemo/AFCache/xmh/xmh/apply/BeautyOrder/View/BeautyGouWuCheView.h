//
//  BeautyGouWuCheView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyProjectModel.h"
@interface BeautyGouWuCheView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UIImageView *im4;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UITableView *tbView1;
//清空
@property (nonatomic, copy)void(^BeautyGouWuCheViewDelBlock)(void);
//增加
@property (copy, nonatomic) void (^BeautGouWuCheAddBlock)(BeautyProjectModel*model);
//减少
@property (copy, nonatomic) void (^BeautGouWuCheReduceBlock)(BeautyProjectModel*model);

- (void)refreshBeautyGouWuCheView;
@end
