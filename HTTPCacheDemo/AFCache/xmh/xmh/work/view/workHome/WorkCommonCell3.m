//
//  WorkCommonCell3.m
//  xmh
//
//  Created by ald_ios on 2018/9/13.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkCommonCell3.h"
#import <YYWebImage/YYWebImage.h>
@interface WorkCommonCell3 ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@end
@implementation WorkCommonCell3
- (void)updateWorkCommonCellSqgjModel:(MzzSqgk *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.headimgurl) placeholder:kDefaultImage];
    _lb1.text = model.user_name;
    _lb2.text = model.mobile;
}
- (void)updateWorkCommonCellDgModel:(WorkUserModel *)model
{
    [_icon yy_setImageWithURL:URLSTR(model.user_img) placeholder:kDefaultCustomerImage];
    _lb1.text = model.user_name;
    _lb2.text = model.user_tel;
}

@end
