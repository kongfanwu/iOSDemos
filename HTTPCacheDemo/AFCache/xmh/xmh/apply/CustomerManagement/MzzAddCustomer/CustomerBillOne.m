//
//  CustomerBillOne.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/25.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "CustomerBillOne.h"
#import "MzzUser_bill.h"
#import "ShareWorkInstance.h"
@implementation CustomerBillOne{
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
- (void)reFreshCustomerBillOnewithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withValue:(NSString *)value WithSource:(NSMutableArray *)sourceArr{
    _lb1.text = title;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(10, (44-_lb1.height)/2.0, _lb1.width, _lb1.height);
    if (_lb1.right > [ShareWorkInstance shareInstance].xiongshabiOrigin) {
        [ShareWorkInstance shareInstance].xiongshabiOrigin=_lb1.right;
    }
    
    _line1.frame = CGRectMake(0, 43, self.width, 1);
    _im1.frame = CGRectMake(self.width - 15 - im.size.width, (44-im.size.height)/2.0, im.size.width, im.size.height);
    
    NSMutableArray *titleArr = [[NSMutableArray alloc]init];
    NSMutableArray *valueArr = [[NSMutableArray alloc]init];

    for (MzzBillCardModel *model in sourceArr) {
        
        [titleArr addObject:model.name?model.name:@""];
        [valueArr addObject:model.code?model.code:@""];
    }
    _picker1.placeholder = placeHolder;
    _picker1.dataTitleArr = titleArr;
    _picker1.dataValueArr = valueArr;
    _picker1.frame = CGRectMake([ShareWorkInstance shareInstance].xiongshabiOrigin+15, _lb1.top, _im1.right - ([ShareWorkInstance shareInstance].xiongshabiOrigin+15), _lb1.height);
}
@end
