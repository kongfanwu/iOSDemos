//
//  CustomerBillOne.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfPickField.h"
@interface CustomerBillOne : UIView
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet SelfPickField *picker1;
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
- (void)reFreshCustomerBillOnewithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withValue:(NSString *)value WithSource:(NSMutableArray *)sourceArr;
@end
