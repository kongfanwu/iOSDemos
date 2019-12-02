//
//  OneStepUserDescripeTableViewCell.h
//  xmh
//
//  Created by 李晓明 on 2017/12/2.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerModel;
/*
 所属门店   1
 顾客姓名   2
 会员等级   3
 顾客电话   4
 */
@interface OneStepUserDescripeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *lb1;

@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
- (void)updateOneStepUserDescripeTableViewCell:(CustomerModel *)model;
@end
