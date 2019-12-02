//
//  CustomerBillFive.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerBillFive : UIView
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
- (void)reFreshCustomerBillFivewithTitle:(NSString *)title withSubTitle:(NSString *)subTitle withSelect:(BOOL )select;
@end
