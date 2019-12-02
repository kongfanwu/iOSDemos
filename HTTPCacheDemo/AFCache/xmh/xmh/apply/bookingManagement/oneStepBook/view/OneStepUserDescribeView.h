//
//  OneStepUserDescribeView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  预约详情 头部显示顾客基本信息

#import <UIKit/UIKit.h>
@class OneStepCustomerModel,CustomerModel,CustomerMessageModel;
@interface OneStepUserDescribeView : UIView
//头像
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
//所属门店
@property (weak, nonatomic) IBOutlet UILabel *lb1;
//顾客姓名
@property (weak, nonatomic) IBOutlet UILabel *lb2;
//顾客电话
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
//会员等级
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic)CustomerMessageModel * cModel;
- (void)updateOneStepUserDescribeView:(CustomerModel *)model;

@end
