//
//  SaleServiceNextCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/10.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleServiceNextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIView *selectBtnContainerView;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;

@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
@property (weak, nonatomic) IBOutlet UILabel *lb11;

@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (strong, nonatomic)NSMutableDictionary * modelDict;
@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;
@property (weak, nonatomic) IBOutlet UIButton *btnFoure;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addConstraint;
@property (weak, nonatomic) IBOutlet UIView *xialaView;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

@property (nonatomic, copy) void (^btnSaleServiceNextBlock)(NSMutableDictionary *dictinside);
@property (nonatomic, copy) void (^btnSaleServiceNextDelBlock)();
@property (nonatomic, copy) void (^btntDeljisBlock)(NSInteger btn,NSMutableDictionary *dictinside);

@end
