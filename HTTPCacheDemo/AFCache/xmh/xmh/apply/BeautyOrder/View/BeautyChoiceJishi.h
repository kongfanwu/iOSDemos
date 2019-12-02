//
//  BeautyChoiceJishi.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyChoiseJishiModel.h"
@class Join_Code;
@interface BeautyChoiceJishi : UIView

@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UITableView *tbView1;

@property (nonatomic, copy)void(^JiangeBlock)(NSString*jianGe);
@property (nonatomic, copy)void(^WeekBlock)(NSString*week);
@property (nonatomic, copy)void(^chooseBlock)(NSString*choose);
@property (nonatomic, copy)void(^YiGouBlock)(NSString*choose);
@property (nonatomic, copy)void(^GuKeBlock)(NSString*choose);

@property (nonatomic, copy)void(^JishiBlock)(BeautyChoiseJishiList*jishimodel);
@property (nonatomic, copy)void(^workChoicePinPaiViewBlock)(NSString*pinPaiStr);
@property (nonatomic, copy)void(^workChoicePinPaiChangeViewBlock)(Join_Code * join_code);
/**
 *按间隔
 */
- (void)refreshBeautyChoiceJishiJiange;

/**
 *按星期
 */
- (void)refreshBeautyChoiceJishiWeek;
/**
 *选技师
 */
- (void)refreshBeautyChoiceJishi;
/**
 *会工作选品牌
 */
- (void)refreshWorkChoicePinPai;
/**
 *会工作筛选项
 */
- (void)refreshWorkChoose;
/**
 *已购置换多退少补等值
 */
- (void)refreshYigouZhiHuan;
/**
 *顾客指标类别/逆向开单选择门店
 */
- (void)refreshGuKeLeiBie:(NSArray *)arr withTitle:(NSString *)title;

@end
