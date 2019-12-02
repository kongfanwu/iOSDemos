//
//  CustomerBillThree.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerBillThree.h"
#import "ShareWorkInstance.h"
@implementation CustomerBillThree

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _lb2.textColor = kLabelText_Commen_Color_3;
    _lb2.font = FONT_SIZE(11);
    _line1.backgroundColor = kBackgroundColor;
    _text1.textColor = kLabelText_Commen_Color_3;
}
- (void)reFreshCustomerBillThreeithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withValue:(NSString *)value{
    _lb1.text = title;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(10, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    if ([title isEqualToString:@"购买金额"] ||[title isEqualToString:@"余额"]) {
      _lb2.text = @"(元)";
    }
    if ([title isEqualToString:@"购买次数"] ||[title isEqualToString:@"剩余次数"]) {
        _lb2.text = @"(次)";
    }
    [_lb2 sizeToFit];
    _lb2.frame =CGRectMake(_lb1.right, _lb1.bottom - _lb2.height, _lb2.width, _lb2.height);
    _line1.frame = CGRectMake(0, 43, self.width, 1);
    _text1.placeholder = placeHolder;
    _text1.frame = CGRectMake([ShareWorkInstance shareInstance].xiongshabiOrigin+15, _lb1.top, self.width - ([ShareWorkInstance shareInstance].xiongshabiOrigin+15), _lb1.height);
}

@end
