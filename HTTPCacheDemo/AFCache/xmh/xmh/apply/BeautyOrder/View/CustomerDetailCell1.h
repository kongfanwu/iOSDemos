//
//  CustomerDetailCell1.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/6.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhangDanMingXiSubModel.h"
@interface CustomerDetailCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
/**
 *刷新CustomerDetailCell1
 */
- (void)reFreshCustomerDetailCell1:(ZhangDanMingXiSubModel*)model;
@end
