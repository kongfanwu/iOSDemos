//
//  SalePerformanceChoiceView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOrderYejiListModel.h"
@interface SalePerformanceChoiceView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIImageView *redLine;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (nonatomic, strong)LOrderYejiListModel * yejiListModel;
@property (weak, nonatomic) IBOutlet UILabel *lbOneTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTwotitle;

@property (nonatomic, copy)void (^SalePerformanceChoiceViewBlock)(NSString * index);
@end
