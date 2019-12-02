//
//  CustomerBillTwo.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfDateField.h"
@interface CustomerBillTwo : UIView
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet SelfDateField *picker1;
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
- (void)reFreshCustomerBillTwowithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withValue:(NSString *)value;
@end
