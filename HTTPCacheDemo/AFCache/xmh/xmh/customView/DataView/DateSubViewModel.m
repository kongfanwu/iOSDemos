//
//  DateSubViewModel.m
//  xmh
//
//  Created by ald_ios on 2018/10/11.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "DateSubViewModel.h"
@interface DateSubViewModel ()

@end
@implementation DateSubViewModel
+ (instancetype)createModelIconName:(NSString *)iconName textName:(NSString *)textName textValue:(NSString *)textValue isShow:(BOOL)isShow
{
    DateSubViewModel * model = [[DateSubViewModel alloc] init];
    model.iconName = iconName;
    model.textName = textName;
    model.textValue = textValue;
    model.isShow = isShow;
    return model;
}
@end
