//
//  CustomerBillTwo.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerBillTwo.h"
#import "ShareWorkInstance.h"
@implementation CustomerBillTwo
{
    UIImage *im;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(15);
    _line1.backgroundColor = kBackgroundColor;
    im = [UIImage imageNamed:@"gengduo"];
    _im1.image = im;
    _picker1.textColor = kLabelText_Commen_Color_3;
}
- (void)reFreshCustomerBillTwowithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withValue:(NSString *)value{
    _lb1.text = title;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(10, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    _line1.frame = CGRectMake(0, 43, self.width, 1);
    _im1.frame = CGRectMake(self.width - 15 - im.size.width, (44-im.size.height)/2.0, im.size.width, im.size.height);
    
    _picker1.placeholder = placeHolder;
    _picker1.frame = CGRectMake([ShareWorkInstance shareInstance].xiongshabiOrigin+15, _lb1.top, _im1.right - ([ShareWorkInstance shareInstance].xiongshabiOrigin+15), _lb1.height);
}

@end
