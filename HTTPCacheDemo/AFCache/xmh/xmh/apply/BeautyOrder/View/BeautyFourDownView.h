//
//  BeautyFourDownView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/20.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyFourDownView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UIImageView *im3;
@property (weak, nonatomic) IBOutlet UIImageView *im4;
@property (weak, nonatomic) IBOutlet UIImageView *im5;

@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;

@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UILabel *lb12;

@property (weak, nonatomic) IBOutlet UIImageView *line3;
@property (weak, nonatomic) IBOutlet UIImageView *line4;

@property (weak, nonatomic) IBOutlet UILabel *lb13;
@property (weak, nonatomic) IBOutlet UILabel *lb14;
@property (weak, nonatomic) IBOutlet UILabel *lb15;
@property (weak, nonatomic) IBOutlet UITextField *text1;

@property (weak, nonatomic) IBOutlet UIImageView *im6;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;


- (void)reFreshBeautyFourDownViewXiangmu:(NSInteger)xiangmuNum daodianNum:(NSInteger)daodianNum zhouqi:(NSInteger)zhouqi jinge:(CGFloat)jine;

- (void)reFreshBeautyFourDownViewJianGe:(NSString *)str;
- (void)reFreshBeautyFourDownViewWeek:(NSString *)str;
- (void)reFreshBeautyFourDownViewJishi:(NSString *)str;

- (void)reFreshCricle:(UIButton *)sender;

@end
