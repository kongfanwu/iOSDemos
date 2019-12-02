//
//  TJCardSearchAndSelectCell.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/3/28.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJCardListModel.h"
#import "TJCardTopModel.h"
@interface TJCardSearchAndSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (strong, nonatomic)TJCardListModel * model;
@property (strong, nonatomic)TJCardTopModel * cardTopModel;
@property (nonatomic, copy)void (^TJCardBlock)(TJCardTopSubModel * model);
@property (nonatomic, copy)void (^TJPaiXuBlock)(NSString * index);
@end
