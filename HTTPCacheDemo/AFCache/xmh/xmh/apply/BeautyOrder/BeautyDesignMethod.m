//
//  BeautyDesignMethod.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "BeautyDesignMethod.h"

@implementation BeautyDesignMethod

+ (NSString *)returnNameWithly_type:(NSString *)ly_typeStr{
    
    NSString *nameStr = @"";
    NSDictionary * dic = @{@"stored_card":@"储值卡",
                           @"card_course":@"疗程卡",
                           @"card_exper":@"体验卡",
                           @"card_time":@"时间卡",
                           @"card_num":@"任选卡",
                           @"free":@"免费专区",
                           @"gpack":@"礼包",
                           @"groups":@"项目众筹",
                           @"bargain":@"人气众筹",
                           @"special_pro":@"特惠项目",
                           @"sys_imp":@"系统导入",
                           @"zhihuan":@"置换",
                           @"sales":@"销售单",
                           @"privilege":@"特权领取"
                           };
    nameStr = dic[ly_typeStr];
    return nameStr;
}
+ (NSString *)returnNameWithBeautyCardPropertyName:(NSString *)propertyname{
    
    NSString *nameStr = @"";
    NSDictionary * dic = @{@"card_time":@"时间卡",
                           @"card_course":@"特惠卡",
                           @"card_num":@"任选卡",
                           @"stored_card":@"储值卡"
                           };
    nameStr = dic[propertyname];
    return nameStr;
}

+ (NSInteger)returnJiangeValue:(NSString *)jiangeStr{
    
    NSInteger jiangeValue;
    NSDictionary * dic = @{@"1天":@"1",
                           @"2天":@"2",
                           @"3天":@"3",
                           @"4天":@"4",
                           @"5天":@"5",
                           @"6天":@"6",
                           @"7天":@"7",
                           @"8天":@"8",
                           @"9天":@"9",
                           @"10天":@"10"
                           };
    jiangeValue = [dic[jiangeStr] integerValue];
    return jiangeValue;
}

+ (NSInteger)returnWeekValue:(NSString *)weekStr{
    
    NSInteger weekValue;
    NSDictionary * dic = @{@"星期一":@"1",
                           @"星期二":@"2",
                           @"星期三":@"3",
                           @"星期四":@"4",
                           @"星期五":@"5",
                           @"星期六":@"6",
                           @"星期日":@"7"
                           };
    weekValue = [dic[weekStr] integerValue];
    return weekValue;
}

+ (NSInteger)returnEnglishWeekValue:(NSString *)weekStr{
    
    NSInteger weekValue;
    NSDictionary * dic = @{@"Monday":@"1",
                           @"Tuesday":@"2",
                           @"Wednesday":@"3",
                           @"Thursday":@"4",
                           @"Friday":@"5",
                           @"Saturday":@"6",
                           @"Sunday":@"7"
                           };
    weekValue = [dic[weekStr] integerValue];
    return weekValue;
}

@end
