//
//  BeautyDesignDownView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeautyDesignDownView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
/**
 *刷新BeautyDesignDownView
 */

- (void)reFreshBeautyDesignDownView:(NSInteger)num;
/**
 *刷新顾客账单
 */
- (void)reFreshBeautyDesignDownViewWithCustomerBill;
@end
